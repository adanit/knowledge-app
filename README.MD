
Projeto de uma aplicação WEB de base de conhecimento para armazenar comandos úteis nas ferramentas de DevOps (Kubernets, Docker, Terraform, Providers, Git e outros)

## Para Rodar localmente

docker compose up -d


Backend (Python e Flask — porta 5000)

GET /api/commands — lista todos (aceita ?category=docker)
POST /api/commands — cria novo
GET /api/commands/:id — detalhe
PUT /api/commands/:id — atualiza
DELETE /api/commands/:id — remove
GET /api/categories — categorias distintas
Cache Redis com TTL de 60s, invalidado a cada escrita


Frontend (Express + EJS — porta 3000)

Sidebar com filtro por categoria
Busca client-side por título/descrição
Botão "Copiar Comando" (clipboard API)
CRUD completo via formulários HTML