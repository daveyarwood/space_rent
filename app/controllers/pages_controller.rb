class PagesController < ApplicationController
  def home
    @people = Person.all
    @messages = Message.order(created_at: :desc).limit(10).reverse
  end
end
