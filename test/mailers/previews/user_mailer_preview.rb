# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    dave = Person.find_by(name: "Dave")
    UserMailer.welcome(dave)
  end

  def rent_is_due
    dave = Person.find_by(name: "Dave")
    UserMailer.rent_is_due(dave)
  end

  def rent_is_late
    dave = Person.find_by(name: "Dave")
    UserMailer.rent_is_late(dave)
  end

end
