# Stage 1: Build the application
FROM python:3.11-slim As builder
WORKDIR /app
COPY requirements.txt .
# Roda o install e copia para /root/.local para o builder
RUN pip install --user -r requirements.txt

# Stage 2: Create the final image
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY . .
RUN useradd -m appuser && chown -R appuser:appuser /app
# Copia os pacotes instalados para o diretório do usuário appuser e ajusta as permissões
RUN cp -r /root/.local /home/appuser/.local && chown -R appuser:appuser /home/appuser/.local
USER appuser
# Adiciona o diretório do usuário ao PATH para garantir que os pacotes instalados localmente sejam encontrados
ENV PATH="/home/appuser/.local/bin:$PATH"
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health').read()" || exit 1

CMD ["python", "app.py"]
