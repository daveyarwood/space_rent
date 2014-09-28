class MessagesController < ApplicationController
  def index
    @messages = Message.order(created_at: :desc).limit(10).reverse
    
    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end
end
