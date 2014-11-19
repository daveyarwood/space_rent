class PaymentsController < ApplicationController
  before_action :authorize, only: [:accept, :reject]

  def create
    @payment = Payment.new(payment_params)
    #@payment = current_user.payments.build(payment_params)
    if @payment.save
      redirect_to root_path
    elsif @payment.errors.full_messages.any? {|m| m =~ /Amount must be less/}
      what_we_owe = number_to_currency(Bill.sum(:owed), unit: "$")
      redirect_to root_path, 
        flash: {error: "You can't pay more than what we owe, #{what_we_owe}."}
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
