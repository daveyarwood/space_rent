class MessagesController < ApplicationController
  def index
    @messages = Message.order(:created_at).limit(10)
  end
end
