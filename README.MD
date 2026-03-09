# Knowledge Base APP

Projeto de uma aplicação WEB de base de conhecimento para armazenar comandos úteis nas ferramentas de DevOps (Kubernets, Docker, Terraform, Providers, Git e outros)

## Para Rodar localmente

docker compose up -d

## Stack do APP

Backend (Python e Flask — porta 5000)

GET /api/commands — lista todos comandos <br>
POST /api/commands — cria novo <br>
GET /api/commands/:id — detalhe <br>
PUT /api/commands/:id — atualiza <br>
DELETE /api/commands/:id — remove <br>
GET /api/categories — categorias distintas <br>
Cache Redis com TTL de 60s, invalidado a cada escrita <br>


Frontend (Express + EJS — porta 3000)

Sidebar com filtro por categoria <br>
Busca client-side por título/descrição <br>
Botão "Copiar Comando" (clipboard API) <br>
CRUD completo via formulários HTML <br>

Banco de dados Postgres - Armazenamento das informações

Redis Cache - Aceleração do APP

--------------------------------------------------------------------------------