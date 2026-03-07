# Knowledge Base APP

Projeto de uma aplicação WEB de base de conhecimento para armazenar comandos úteis nas ferramentas de DevOps (Kubernets, Docker, Terraform, Providers, Git e outros)

## Para Rodar localmente

docker compose up -d


# Otimizações (06/03/26)

1 - Backend: Multi stage build reduzindo o tamanho da imagem consideravelmente  (ver imagens /docs) <br>
2 - Backend: Remoção da execução do container como root para appuser, seguindo boas praticas de segurança <br>
3 - Backend: Adicionado Heathcheck para maior controle da saude do container e futturas utilizações em orquestradores <br>

4 - Frontend: Multi stage build reduzindo o tamanho da imagem consideravelmente  (ver imagens /docs) <br>
5 - Frontend: Remoção da execução do container como root para appuser, seguindo boas praticas de segurança <br>
6 - Frontend: Adicionado Heathcheck para maior controle da saude do container e futturas utilizações em orquestradores <br>

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