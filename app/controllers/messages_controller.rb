class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :desc).limit(20).reverse
    
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end
end
