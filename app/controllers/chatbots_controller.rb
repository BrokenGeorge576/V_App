class ChatbotsController < ApplicationController
  def show
    @managed_file = ManagedFile.find(params[:managed_file_id])
    @document_text = TextExtractorService.new(@managed_file).call
  end

  def create
    document_text = params[:document_text]
    question = params[:question]
    answer = GroqChatbotService.new(document_text, question).call
    render json: { answer: answer }
  end
end