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

  def Bill.split_rent(amount)
    share = amount.to_f / Person.count
    Person.find_each {|person| person.update(owes: person.owes + share)}
  end

  def Bill.monthly_bill
    Bill.create(owed: ENV["RENT_AMOUNT"].to_i)
  end

  def Bill.late_fee
    bill = Bill.last
    bill.update(owed: bill.owed + ENV["LATE_FEE"], late: true)
  end

  def Bill.late_notice
    if Bill.sum(:owed) > 0
      Person.find_each(conditions: "owes > 0") do |person| 
        UserMailer.rent_is_late(person).deliver
      end
    end
  end

end
