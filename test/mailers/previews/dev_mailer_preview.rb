# Preview all emails at http://localhost:3000/rails/mailers/dev_mailer
class DevMailerPreview < ActionMailer::Preview
  def bill_creation_error
    DevMailer.bill_creation_error(Bill.create(owed: nil))
  end
end
