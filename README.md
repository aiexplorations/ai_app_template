
# AI App Template
This repository serves as a template for creating AI applications. It provides a basic structure and common configurations to help you get started quickly with your AI projects.

This is a template for creating projects with:
1. Dockerized FastAPI backend with database support.
2. Machine learning text completion/chat with Ollama.
3. Simple HTML, CSS, and JS frontend with dark mode and chatbot interface.


## Backend
The backend is built using Python and FastAPI. It provides the following features:
- RESTful API endpoint for chat completion with the Llama3.1 model running on Ollama (locally).

## Docker
The repository includes Docker configurations to containerize the application. It provides the following features:
- Dockerfile for building the application image.
- Docker Compose file for orchestrating multi-container applications.
- Pre-configured environment variables for easy setup.
- Currently it includes Neo4J in addition to the backend for Python/FastAPI

## Frontend
The frontend is built using simple HTML, CSS and JS. It is a barebones, easy to maintain chat interface for a simple chat bot.

# Uses
This template is meant to automate the boring stuff when starting to explore a full stack app idea. It gets users off the ground.

0. Prerequisites
    * Ensure you have Ollama installed with the Llama3.1 model
    * Ensure you have your Python environment installed and capable of using this code base
1. Use this repo as a template when building your own.
2. Run `docker-compose up --build` to start the services.
3. Access the frontend at `http://localhost:8000`.


## Usage

- The backend FastAPI service is available at `http://localhost:8000`.
- Ollama API is available at `http://localhost:11434/api/generate`.
