# app/services/groq_chatbot_service.rb
require 'httparty'

class GroqChatbotService
  include HTTParty
  base_uri 'https://api.groq.com/openai'

  def initialize(document_text, question)
    @document_text = document_text
    @question = question
    @api_key = Rails.application.credentials.groq&.dig(:api_key)
  end

  def call
    unless @api_key
      return "Error: La clave de API de Groq no está configurada."
    end

    system_prompt = <<~PROMPT
      Eres un asistente experto llamado Vicky. Tu única tarea es responder preguntas basándote exclusivamente en el siguiente texto de un documento. Intenta buscar en otros
      lugares si es necesario la informacion, para que tu respuesta sea la mejor posible.
      Quiero que intentes ser siempre cordial con el usuario y amable, para que no se sienta mal de no saber las cosas, lo que el usuario te pregunte sobre el documento
      investiga a fondo, intenta organizar tus respuestas en parrafos, sin usar emojis u otras cosas que afecten la visualizacion,usa solo texto y lo unico permitido que puedes
      usar son caritas de este tipo ":)" este es un ejemplo, intenta tener la actitud de una amiga adolescente
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
        model: "llama-3.3-70b-versatile",
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