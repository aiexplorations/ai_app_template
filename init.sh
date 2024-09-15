#!/bin/bash

# Create the project directory structure
mkdir -p project-template/backend/app/models
mkdir -p project-template/backend/app/routes
mkdir -p project-template/backend/app/utils
mkdir -p project-template/backend/tests
mkdir -p project-template/frontend
mkdir -p project-template/docker

# Create backend FastAPI entry point (main.py)
cat <<EOL > project-template/backend/app/main.py
from fastapi import FastAPI, HTTPException
import requests

app = FastAPI()

OLLAMA_API_URL = "http://localhost:11434/api/generate"

@app.post("/chat")
async def chat_completion(prompt: str):
    payload = {"prompt": prompt, "model": "llama3.1", "stream": False}
    response = requests.post(OLLAMA_API_URL, json=payload)

    if response.status_code == 200:
        return {"response": response.json()}
    else:
        raise HTTPException(status_code=500, detail="Error completing text.")
EOL

# Create requirements.txt
cat <<EOL > project-template/backend/requirements.txt
fastapi
requests
pytest
uvicorn
EOL

# Create tests placeholder
touch project-template/backend/tests/__init__.py

# Create Dockerfile for backend
cat <<EOL > project-template/docker/Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory
WORKDIR /usr/src/app

# Copy the current directory contents into the container
COPY ./backend /usr/src/app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run FastAPI server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
EOL

# Create docker-compose.yml
cat <<EOL > project-template/docker/docker-compose.yml
version: '3.8'

services:
  backend:
    build: ./backend
    ports:
      - "8000:8000"
    depends_on:
      - db

  db:
    image: neo4j:latest
    ports:
      - "7474:7474"
      - "7687:7687"
    environment:
      - NEO4J_AUTH=neo4j/test

  ollama:
    image: ollama/ollama-local
    ports:
      - "11434:11434"
EOL

# Create frontend HTML, CSS, and JS files
cat <<EOL > project-template/frontend/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Chatbot</title>
</head>
<body>
    <div class="chat-container">
        <div id="chat-box"></div>
        <input id="user-input" type="text" placeholder="Type your message...">
        <button onclick="sendMessage()">Send</button>
    </div>
    <script src="app.js"></script>
</body>
</html>
EOL

cat <<EOL > project-template/frontend/styles.css
body {
    background-color: #121212;
    color: #ffffff;
    font-family: Arial, sans-serif;
}

.chat-container {
    width: 80%;
    margin: auto;
    padding: 20px;
}

input, button {
    padding: 10px;
    border: none;
    border-radius: 5px;
    margin-top: 10px;
    width: 100%;
}

input {
    background-color: #2a2a2a;
    color: white;
}

button {
    background-color: #1a73e8;
    color: white;
}

#chat-box {
    height: 300px;
    overflow-y: scroll;
    background-color: #333333;
    padding: 10px;
}
EOL

cat <<EOL > project-template/frontend/app.js
async function sendMessage() {
    const userInput = document.getElementById('user-input').value;
    const chatBox = document.getElementById('chat-box');

    const response = await fetch('/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt: userInput })
    });

    const data = await response.json();
    chatBox.innerHTML += \`<p><b>You:</b> \${userInput}</p>\`;
    chatBox.innerHTML += \`<p><b>Bot:</b> \${data.response}</p>\`;
    document.getElementById('user-input').value = '';
}
EOL

# Create README.md
cat <<EOL > project-template/README.md
# Project Template

This is a template for creating projects with:
1. Dockerized FastAPI backend with database support.
2. Machine learning text completion/chat with Ollama.
3. Simple HTML, CSS, and JS frontend with dark mode and chatbot interface.

## Setup

1. Clone the repo.
2. Run \`docker-compose up --build\` to start the services.
3. Access the frontend at \`http://localhost:8000\`.

## Usage

- The backend FastAPI service is available at \`http://localhost:8000\`.
- Ollama API is available at \`http://localhost:11434/api/generate\`.
EOL

# Final message
echo "Project template initialized! You can now push this folder to GitHub as a template repository."
