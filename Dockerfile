
FROM python:3.10-slim-bullseye

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements first (better cache usage)
COPY requirements.txt /requirements.txt

# Upgrade pip and install requirements
RUN pip3 install --no-cache-dir -U pip && \
    pip3 install --no-cache-dir -r /requirements.txt

# Create app directory
WORKDIR /DQTheFileDonor

# Copy project files
COPY . /DQTheFileDonor

# Make start.sh executable
RUN chmod +x /start.sh

# Expose port for healthcheck
EXPOSE 8080

# Start the bot
CMD ["/bin/bash", "/start.sh"]