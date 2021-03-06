# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Person.delete_all
Bill.delete_all
Message.delete_all
Payment.delete_all

dave = Person.create(name: "Dave", password: "dave",
                     email: "dave.yarwood@gmail.com", admin: true)

Person.create(name: "Daniel", password: "daniel", email: "test@example.com")
Person.create(name: "Elliott", password: "elliott", email: "test@example.com")
Person.create(name: "Osamu", password: "osamu", email: "test@example.com")

# Bill.create(owed: 285)

Message.create(person: dave, name: "Dave", text: "test message")
Message.create(person: dave, name: "Dave", log_message: true, text: "left a log message.")
