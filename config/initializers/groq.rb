ENV["GROQ_API_KEY"] ||= Rails.application.credentials.dig(:groq, :api_key)
