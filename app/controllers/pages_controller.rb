class PagesController < ApplicationController
  def home
    @messages = Message.order(created_at: :desc).limit(10).reverse
  end
end
