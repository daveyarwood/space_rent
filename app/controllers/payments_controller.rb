class PaymentsController < ApplicationController
  before_action :authorize, only: [:accept, :reject]

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      DevMailer.payment_received(@payment.person, @payment.amount).deliver
      redirect_to root_path
    elsif @payment.errors.full_messages.any? {|m| m =~ /Amount must be less/}
      what_we_owe = ActionController::Base.helpers.number_to_currency(Bill.sum(:owed), unit: "$")
      redirect_to root_path, 
        flash: {error: "You can't pay more than what we owe, #{what_we_owe}."}
    elsif @payment.errors.full_messages.any? {|m| m =~ /Amount is not a number/}
      redirect_to root_path, flash: {error: "That's not a valid payment amount."}
    else
      redirect_to root_path, flash: {error: "ERROR"} 
    end
  end
  
  def accept
    @person = @payment.person
    Bill.pay(@payment.amount)
    @person.update(owes: @person.owes - @payment.amount)
    @payment.destroy
    redirect_to admin_path, notice: "Payment accepted."
    amount_for_message = ActionController::Base.helpers.number_to_currency @payment.amount, unit: "$"
    @person.messages.create(name: @person.name, log_message: true, text: "paid #{amount_for_message}.")
  end
  
  def reject
    @payment.destroy
    redirect_to admin_path, notice: "Payment rejected."
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :person_id)
  end

  def authorize
    @payment = Payment.find(params[:id])
    unless current_user.admin?
      redirect_to root_path, 
        flash: {error: "Hey, you're not allowed to do that!"}
    end
  end
end
