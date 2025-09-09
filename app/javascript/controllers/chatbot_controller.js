import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["history", "input", "form"]
  static values = {
    url: String,
    documentText: String
  }

  connect() {
    this.formTarget.addEventListener("submit", (e) => this.sendMessage(e))
  }

  async sendMessage(event) {
    event.preventDefault();
    const question = this.inputTarget.value.trim();
    if (question === "") return;

    this.appendMessage(question, "user");
    this.inputTarget.value = "";

    const thinkingMessage = this.appendMessage("Vicky está pensando...", "bot", true);

    try {
      const response = await fetch(this.urlValue, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({
          question: question,
          document_text: this.documentTextValue
        })
      });

      if (!response.ok) {
        throw new Error("Error en la respuesta del servidor.");
      }

      const data = await response.json();
      thinkingMessage.innerHTML = data.answer;

    } catch (error) {
      console.error("Error en el chatbot:", error);
      thinkingMessage.innerHTML = "Lo siento, ocurrió un error al procesar tu pregunta.";
    }
  }

  appendMessage(content, sender, isThinking = false) {
    const messageDiv = document.createElement("div");
    messageDiv.classList.add("chat-message", `${sender}-message`, "mb-2");
    messageDiv.innerHTML = content;

    if (isThinking) {
      messageDiv.classList.add("thinking");
    }

    this.historyTarget.appendChild(messageDiv);
    this.historyTarget.scrollTop = this.historyTarget.scrollHeight;
    return messageDiv;
  }
}