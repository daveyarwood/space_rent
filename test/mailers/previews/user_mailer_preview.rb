# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def welcome
    dave = Person.find_by(name: "Dave")
    UserMailer.welcome(dave)
  end

end
