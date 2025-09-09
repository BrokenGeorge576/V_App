# app/services/groq_chatbot_service.rb
require 'httparty'

class GroqChatbotService
  include HTTParty
  # Cambiamos la URL base a la de Groq
  base_uri 'https://api.groq.com/openai'

  def initialize(document_text, question)
    @document_text = document_text
    @question = question
    # Apuntamos a las nuevas credenciales de Groq
    @api_key = Rails.application.credentials.groq&.dig(:api_key)
  end

  def call
    unless @api_key
      return "Error: La clave de API de Groq no está configurada."
    end

    system_prompt = <<~PROMPT
      Eres un asistente experto llamado Vicky. Tu única tarea es responder preguntas basándote exclusivamente en el siguiente texto de un documento.
      No inventes información ni respondas usando conocimiento general. Si la respuesta no se encuentra en el texto, indica amablemente que la información no está disponible en el documento.
      ---
      CONTENIDO DEL DOCUMENTO:
      #{@document_text}
      ---
    PROMPT

    options = {
      headers: {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      },
      body: {
        # Usamos un modelo disponible en Groq (Llama 3 es excelente)
        model: "llama-3.1-8b-instant",
        messages: [
          { role: "system", content: system_prompt },
          { role: "user", content: @question }
        ]
      }.to_json,
      timeout: 120
    }

    response = self.class.post("/v1/chat/completions", options)

    if response.success?
      response.parsed_response.dig('choices', 0, 'message', 'content')&.strip
    else
      error_details = response.parsed_response.is_a?(Hash) ? response.parsed_response.dig('error', 'message') : response.body
      Rails.logger.error "Error en la API de Groq: #{error_details}"
      "Lo siento, ocurrió un error con la IA de Groq. Detalles: #{error_details}".truncate(150)
    end
  rescue => e
    Rails.logger.error "Error de conexión con Groq: #{e.message}"
    "Lo siento, no pude conectarme con el servicio de inteligencia artificial."
  end
end