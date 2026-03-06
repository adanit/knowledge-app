const express = require('express');
const axios   = require('axios');
const path    = require('path');

const app     = express();
const PORT    = 3000;
const API_URL = process.env.API_URL || 'http://localhost:5000';

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// ----------------------------------------------------------------
// GET / - lista de comandos (com filtro por categoria)
// ----------------------------------------------------------------
app.get('/', async (req, res) => {
    try {
        const category = req.query.category || '';
        const listUrl  = category
            ? `${API_URL}/api/commands?category=${encodeURIComponent(category)}`
            : `${API_URL}/api/commands`;

        const [commandsRes, categoriesRes] = await Promise.all([
            axios.get(listUrl),
            axios.get(`${API_URL}/api/categories`),
        ]);

        res.render('index', {
            commands:         commandsRes.data,
            categories:       categoriesRes.data,
            selectedCategory: category,
            error:            null,
        });
    } catch (err) {
        res.render('index', {
            commands:         [],
            categories:       [],
            selectedCategory: '',
            error:            'Nao foi possivel conectar a API. Verifique se o backend esta rodando.',
        });
    }
});

// ----------------------------------------------------------------
// GET /new - formulario de criacao
// ----------------------------------------------------------------
app.get('/new', (req, res) => {
    res.render('create', { error: null });
});

// ----------------------------------------------------------------
// POST /new - salva novo comando
// ----------------------------------------------------------------
app.post('/new', async (req, res) => {
    try {
        const { title, command, description, category } = req.body;
        await axios.post(`${API_URL}/api/commands`, { title, command, description, category });
        res.redirect('/');
    } catch (err) {
        const message = err.response?.data?.error || 'Erro ao salvar o comando. Tente novamente.';
        res.render('create', { error: message });
    }
});

// ----------------------------------------------------------------
// GET /command/:id - detalhe de um comando
// ----------------------------------------------------------------
app.get('/command/:id', async (req, res) => {
    try {
        const response = await axios.get(`${API_URL}/api/commands/${req.params.id}`);
        res.render('detail', { command: response.data });
    } catch (err) {
        res.redirect('/');
    }
});

// ----------------------------------------------------------------
// GET /command/:id/edit - formulario de edicao
// ----------------------------------------------------------------
app.get('/command/:id/edit', async (req, res) => {
    try {
        const response = await axios.get(`${API_URL}/api/commands/${req.params.id}`);
        res.render('edit', { command: response.data, error: null });
    } catch (err) {
        res.redirect('/');
    }
});

// ----------------------------------------------------------------
// POST /command/:id/edit - atualiza comando
// ----------------------------------------------------------------
app.post('/command/:id/edit', async (req, res) => {
    try {
        const { title, command, description, category } = req.body;
        await axios.put(`${API_URL}/api/commands/${req.params.id}`, {
            title, command, description, category,
        });
        res.redirect(`/command/${req.params.id}`);
    } catch (err) {
        const cmdRes  = await axios.get(`${API_URL}/api/commands/${req.params.id}`);
        const message = err.response?.data?.error || 'Erro ao atualizar o comando.';
        res.render('edit', { command: cmdRes.data, error: message });
    }
});

// ----------------------------------------------------------------
// POST /command/:id/delete - remove comando
// ----------------------------------------------------------------
app.post('/command/:id/delete', async (req, res) => {
    try {
        await axios.delete(`${API_URL}/api/commands/${req.params.id}`);
    } catch (_) {
        // ignora erros de delete, redireciona de qualquer forma
    }
    res.redirect('/');
});

app.listen(PORT, () => {
    console.log(`Frontend rodando em http://localhost:${PORT}`);
    console.log(`Conectando na API: ${API_URL}`);
});
