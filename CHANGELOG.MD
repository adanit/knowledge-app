## Otimizações 

(06/03/26) <br>
1 - Backend: Multi stage build reduzindo o tamanho da imagem consideravelmente  (ver imagens /docs) <br>
2 - Backend: Remoção da execução do container como root para appuser, seguindo boas praticas de segurança <br>
3 - Backend: Adicionado Heathcheck para maior controle da saude do container e futturas utilizações em orquestradores <br>

4 - Frontend: Multi stage build reduzindo o tamanho da imagem consideravelmente  (ver imagens /docs) <br>
5 - Frontend: Remoção da execução do container como root para appuser, seguindo boas praticas de segurança <br>
6 - Frontend: Adicionado Heathcheck para maior controle da saude do container e futturas utilizações em orquestradores <br>

(09/03/26) <br>
1 - Remoção de variáveis de ambiente do dockerfile