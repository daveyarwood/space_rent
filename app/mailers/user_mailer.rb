class UserMailer < ActionMailer::Base
  default from: "dave.yarwood@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def welcome(person)
    @person = person
    mail to: person.email, subject: "Welcome to spacerent"
  end
end
