class Bill < ActiveRecord::Base
  validates_presence_of :owed
  
  def Bill.pay(amount)
    raise "Can't pay more than we owe!" if amount > Bill.sum(:owed)
    
    while amount > 0
      bill = Bill.where("owed > 0").last
      if bill.owed >= amount
        bill.update(owed: bill.owed - amount)
        amount = 0
      elsif bill.owed < amount
        amount -= bill.owed
        bill.update(owed: 0)
      end
    end
  end

  def Bill.split_amount(amount, people)
    share = amount.to_f / people.count
    people.find_each {|person| person.update(owes: person.owes + share)}
  end

end
