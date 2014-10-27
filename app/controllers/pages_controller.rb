class PagesController < ApplicationController
  before_action :authorize, only: [:admin]

  def home
    @people = Person.all
    @messages = Message.order(created_at: :desc).limit(20).reverse
    if signed_in?
      @message = Message.new(person: current_user)
      @payment = current_user.payments.build(amount: current_user.owes)
    end
  end

  def admin
    @people = Person.all
    @payments = Payment.all
  end

  private

  def authorize
    unless signed_in? && current_user.admin?
      redirect_to root_path,
        flash: {error: "You have to be logged in as an admin to do that."}
    end
  end
end
