FROM python:3.10-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive

# Install git
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt /requirements.txt

# Install deps
RUN pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r /requirements.txt

# Workdir
WORKDIR /app

# Copy everything (including start.sh)
COPY . /app

# Make start.sh executable
RUN chmod +x /app/start.sh

# Expose port for Koyeb
EXPOSE 8080

# Run bot
CMD ["bash", "/app/start.sh"]