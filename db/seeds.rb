# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
preroll = Preroll.create( date: Date.today, action_id: 1, loc1: 1, loc2:1)
blankloc = Location.create([{name: "", available: false, active: false},{name: "Ordered", available: false, active:true}])
actions = Action.create([{action: 'Sell', impact: -1}, {action: 'Add/Order', impact: 1}, {action: 'Transfer', impact: 0}, {action: 'Adjustment', impact:0}])