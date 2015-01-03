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
    rent_amount = ENV["RENT_AMOUNT"].to_f
    Bill.create(owed: rent_amount)
    Bill.split_rent(rent_amount)
    Person.where(email_me: true).find_each do |person| 
      UserMailer.rent_is_due(person).deliver
    end
  end

  def Bill.late_fee
    late_fee = ENV["LATE_FEE"].to_f
    bill = Bill.last
    bill.update(owed: bill.owed + late_fee, late: true)
    # split the late fee between everyone who hasn't paid yet
    slackers = Person.where("owes > 0")
    late_fee_share = late_fee.to_f / slackers.count
    slackers.find_each {|person| person.update(owes: person.owes + late_fee_share)}
  end

  def Bill.late_notice
    if Bill.sum(:owed) > 0
      Person.where("owes > 0 AND email_me = true").find_each do |person| 
        UserMailer.rent_is_late(person).deliver
      end
    end
  end

  def Bill.rent_is_late
    Bill.late_fee
    Bill.late_notice
  end

end
