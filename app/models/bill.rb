require 'bigdecimal'
require_relative '../../lib/round_down'

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
    rounded_share = BigDecimal.new((amount.to_f / people.count).round_down(2).to_s)
    shares = [rounded_share] * people.count
    extra_cents_owed = ((BigDecimal.new(amount.to_s) - shares.inject(&:+)) * 100).to_i
    extra_cents_owed.times do
      shares[rand(shares.count)] += 0.01
    end
    people.find_each {|person| person.update(owes: person.owes + shares.pop)}
  end

end
