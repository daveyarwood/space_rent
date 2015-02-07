class DevMailer < ActionMailer::Base
  default from: "dave.yarwood@gmail.com"

  def bill_creation_error(bill)
    @bill = bill
    @month = Date.today.at_beginning_of_month.next_month.strftime("%B")
    mail to: "dave.yarwood@gmail.com", subject: "#{@month} bill failed to save"
  end

  def payment_received(person, amount)
    @person = person
    @amount = amount
    mail to: Person.admins.pluck(:email), subject: "#{@person.name} made a payment"
  end
end
