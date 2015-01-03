namespace :rent do
  desc "Create a new bill in the amount of monthly rent, divide the amount
        evenly among the people, and send out rent reminder emails."
  task monthly: :environment do
    rent_amount = ENV["RENT_AMOUNT"].to_f
    Bill.create(owed: rent_amount)
    Bill.split_amount(rent_amount, Person.all)
    Person.where(email_me: true).find_each do |person| 
      UserMailer.rent_is_due(person).deliver
    end
  end

  desc "Add late fee to the last bill and mark it late, divide the late fee
        among those who haven't paid, and send out late notice emails."
  task late: :environment do
    if Bill.sum(:owed) > 0
      late_fee = ENV["LATE_FEE"].to_f
      bill = Bill.last
      bill.update(owed: bill.owed + late_fee, late: true)

      slackers = Person.where("owes > 0")
      Bill.split_amount(late_fee, slackers)
      slackers.where(email_me: true).find_each do |person| 
        UserMailer.rent_is_late(person).deliver
      end
    end
  end

end
