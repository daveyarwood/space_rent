class Tab < ActiveRecord::Base
  validates_presence_of :name, :amount
  validates_uniqueness_of :name
end
