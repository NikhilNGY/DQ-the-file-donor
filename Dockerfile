FROM python:3.10-slim-bullseye

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install git (needed for some bots)
RUN apt-get update && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for caching
COPY requirements.txt /requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -U pip \
    && pip install --no-cache-dir -r /requirements.txt

# Set working directory
WORKDIR /app

# Copy all project files
COPY . /app

# Make start.sh executable
RUN chmod +x /start.sh

# Expose port for Koyeb health check
EXPOSE 8080

# Start the bot
CMD ["bash", "/start.sh"]