async function sendMessage() {
    const userInput = document.getElementById('user-input').value;
    const chatBox = document.getElementById('chat-box');

    const response = await fetch('/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt: userInput })
    });

    const data = await response.json();
    chatBox.innerHTML += `<p><b>You:</b> ${userInput}</p>`;
    chatBox.innerHTML += `<p><b>Bot:</b> ${data.response}</p>`;
    document.getElementById('user-input').value = '';
}
