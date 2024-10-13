# Usar a imagem base do Python
FROM python:3.9-slim

# Definir o diretório de trabalho no contêiner
WORKDIR /app

# Instalar dependências do sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libsndfile1 \
    git && \
    rm -rf /var/lib/apt/lists/*

# Clonar o repositório do Coqui TTS
RUN git clone https://github.com/coqui-ai/TTS.git /app/TTS

# Instalar as dependências Python
RUN pip install --upgrade pip
RUN pip install -r /app/TTS/requirements.txt

# Instalar Redis e Postgres para integração
RUN pip install redis psycopg2

# Configurar para rodar o TTS
CMD ["python", "TTS/bin/run_tts.py"]
