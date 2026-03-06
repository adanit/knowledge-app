import json
import os
import time

import psycopg2
import redis
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

DATABASE_URL = os.environ.get(
    'DATABASE_URL',
    'postgresql://knowledge_user:knowledge_pass@localhost:5432/knowledge_db'
)
REDIS_URL = os.environ.get('REDIS_URL', 'redis://localhost:6379')

redis_client = redis.from_url(REDIS_URL)


def get_db():
    return psycopg2.connect(DATABASE_URL)


def init_db():
    retries = 10
    while retries > 0:
        try:
            conn = get_db()
            cur = conn.cursor()
            cur.execute('''
                CREATE TABLE IF NOT EXISTS commands (
                    id          SERIAL PRIMARY KEY,
                    title       VARCHAR(255) NOT NULL,
                    command     TEXT NOT NULL,
                    description TEXT,
                    category    VARCHAR(100) NOT NULL,
                    created_at  TIMESTAMP DEFAULT NOW()
                )
            ''')
            conn.commit()
            cur.close()
            conn.close()
            print("Database initialized successfully")
            return
        except Exception as e:
            print(f"Database not ready, retrying in 3s... ({e})")
            retries -= 1
            time.sleep(3)
    raise Exception("Could not connect to database after multiple retries")


# ------------------------------------------------------------------
# GET /api/commands?category=docker
# ------------------------------------------------------------------
@app.route('/api/commands', methods=['GET'])
def list_commands():
    category = request.args.get('category', '').strip()
    cache_key = f'commands:{category or "all"}'

    cached = redis_client.get(cache_key)
    if cached:
        return jsonify(json.loads(cached))

    conn = get_db()
    cur = conn.cursor()

    if category:
        cur.execute(
            'SELECT id, title, command, description, category, created_at '
            'FROM commands WHERE category = %s ORDER BY created_at DESC',
            (category,)
        )
    else:
        cur.execute(
            'SELECT id, title, command, description, category, created_at '
            'FROM commands ORDER BY created_at DESC'
        )

    rows = cur.fetchall()
    cur.close()
    conn.close()

    commands = [
        {
            'id': row[0],
            'title': row[1],
            'command': row[2],
            'description': row[3],
            'category': row[4],
            'created_at': str(row[5]),
        }
        for row in rows
    ]

    redis_client.setex(cache_key, 60, json.dumps(commands))
    return jsonify(commands)


# ------------------------------------------------------------------
# GET /api/commands/<id>
# ------------------------------------------------------------------
@app.route('/api/commands/<int:command_id>', methods=['GET'])
def get_command(command_id):
    cache_key = f'command:{command_id}'

    cached = redis_client.get(cache_key)
    if cached:
        return jsonify(json.loads(cached))

    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        'SELECT id, title, command, description, category, created_at '
        'FROM commands WHERE id = %s',
        (command_id,)
    )
    row = cur.fetchone()
    cur.close()
    conn.close()

    if not row:
        return jsonify({'error': 'Command not found'}), 404

    command = {
        'id': row[0],
        'title': row[1],
        'command': row[2],
        'description': row[3],
        'category': row[4],
        'created_at': str(row[5]),
    }

    redis_client.setex(cache_key, 60, json.dumps(command))
    return jsonify(command)


# ------------------------------------------------------------------
# POST /api/commands
# ------------------------------------------------------------------
@app.route('/api/commands', methods=['POST'])
def create_command():
    data = request.get_json()

    if not data or not data.get('title') or not data.get('command') or not data.get('category'):
        return jsonify({'error': 'title, command and category are required'}), 400

    conn = get_db()
    cur = conn.cursor()
    cur.execute(
        'INSERT INTO commands (title, command, description, category) '
        'VALUES (%s, %s, %s, %s) RETURNING id',
        (data['title'], data['command'], data.get('description', ''), data['category'])
    )
    new_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()

    # Invalidate list caches
    redis_client.delete('commands:all')
    redis_client.delete(f'commands:{data["category"]}')

    return jsonify({'id': new_id, 'message': 'Command created successfully'}), 201


# ------------------------------------------------------------------
# PUT /api/commands/<id>
# ------------------------------------------------------------------
@app.route('/api/commands/<int:command_id>', methods=['PUT'])
def update_command(command_id):
    data = request.get_json()

    if not data or not data.get('title') or not data.get('command') or not data.get('category'):
        return jsonify({'error': 'title, command and category are required'}), 400

    conn = get_db()
    cur = conn.cursor()

    cur.execute('SELECT category FROM commands WHERE id = %s', (command_id,))
    row = cur.fetchone()
    if not row:
        cur.close()
        conn.close()
        return jsonify({'error': 'Command not found'}), 404

    old_category = row[0]
    cur.execute(
        'UPDATE commands SET title = %s, command = %s, description = %s, category = %s '
        'WHERE id = %s',
        (data['title'], data['command'], data.get('description', ''), data['category'], command_id)
    )
    conn.commit()
    cur.close()
    conn.close()

    # Invalidate relevant caches
    redis_client.delete(f'command:{command_id}')
    redis_client.delete('commands:all')
    redis_client.delete(f'commands:{old_category}')
    redis_client.delete(f'commands:{data["category"]}')

    return jsonify({'message': 'Command updated successfully'})


# ------------------------------------------------------------------
# DELETE /api/commands/<id>
# ------------------------------------------------------------------
@app.route('/api/commands/<int:command_id>', methods=['DELETE'])
def delete_command(command_id):
    conn = get_db()
    cur = conn.cursor()

    cur.execute('SELECT category FROM commands WHERE id = %s', (command_id,))
    row = cur.fetchone()
    if not row:
        cur.close()
        conn.close()
        return jsonify({'error': 'Command not found'}), 404

    category = row[0]
    cur.execute('DELETE FROM commands WHERE id = %s', (command_id,))
    conn.commit()
    cur.close()
    conn.close()

    redis_client.delete(f'command:{command_id}')
    redis_client.delete('commands:all')
    redis_client.delete(f'commands:{category}')

    return jsonify({'message': 'Command deleted successfully'})


# ------------------------------------------------------------------
# GET /api/categories
# ------------------------------------------------------------------
@app.route('/api/categories', methods=['GET'])
def list_categories():
    conn = get_db()
    cur = conn.cursor()
    cur.execute('SELECT DISTINCT category FROM commands ORDER BY category')
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([row[0] for row in rows])


# ------------------------------------------------------------------
# GET /health
# ------------------------------------------------------------------
@app.route('/health', methods=['GET'])
def health():
    return jsonify({'status': 'ok'})


if __name__ == '__main__':
    init_db()
    # debug=True apenas para desenvolvimento, desative em producao
    app.run(host='0.0.0.0', port=5000, debug=True)
