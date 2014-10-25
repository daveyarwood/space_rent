class PagesController < ApplicationController
  before_action :authorize, only: [:admin]

  def home
    @people = Person.all
    @messages = Message.order(created_at: :desc).limit(20).reverse
    @message = Message.new(person: current_user) if signed_in?
  end

  def admin

  end

  private

  def authorize
    unless signed_in? && current_user.admin?
      redirect_to root_path,
        flash: {error: "You have to be logged in as an admin to do that."}
    end
  end
end
