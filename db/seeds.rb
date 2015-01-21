# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
groups = Group.create([{name: "Mansions"}, {name: "Meatball"}])
users = User.create([{email: 'browder.c@gmail.com', password: 'tangerine', password_confirmation: 'tangerine', group_id: 1, admin: true}, {email: 'robin.dove@gmail.com', password: 'tangerine', password_confirmation: 'tangerine', group_id: 2, admin: false}])
blankloc = Location.create([{name: "", available: false, active: false},{name: "Ordered", available: false, active:true}])
actions = Action.create([{action: 'Sell', impact: -1}, {action: 'Add/Order', impact: 1}, {action: 'Transfer', impact: 0}, {action: 'Adjustment', impact:0}])