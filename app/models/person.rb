class Person < ActiveRecord::Base
  has_many :messages
  has_secure_password

  validates_presence_of :name, :password, :email
  validates_confirmation_of :password
  validates_uniqueness_of :name, case_sensitive: false
  validates_format_of :email, with: /.+@.+/
end