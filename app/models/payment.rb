class Payment < ActiveRecord::Base
  belongs_to :person
  validates_presence_of :person, :amount
  validates_numericality_of :amount, on: :create, 
                                     less_than_or_equal_to: Bill.sum(:owed)
end
