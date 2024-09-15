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
