class UserMailer < ActionMailer::Base
  default from: "dave.yarwood@gmail.com"

  def welcome(person, password)
    @person = person
    @password = password
    mail to: @person.email, subject: "Welcome to spacerent"
  end

  def rent_is_due(person)
    @person = person
    @month = Date.today.at_beginning_of_month.next_month.strftime("%B")
    mail to: @person.email, subject: "Rent is due for #{@month}"
  end

  def rent_is_late(person)
    @person = person
    mail to: @person.email, subject: "Rent is late"
  end
end
