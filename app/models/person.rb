class Person < ActiveRecord::Base
  has_many :messages
  validates_presence_of :name, :password
  validates_uniqueness_of :name
end
