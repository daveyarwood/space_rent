class MessagesController < ApplicationController
  def index
    @messages = Message.order(:created_at).limit(10)
    
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end
end
