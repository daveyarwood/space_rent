class PagesController < ApplicationController
  def home
    @messages = Message.order(:created_at).limit(10)
  end
end
