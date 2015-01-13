# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
action_types = ActionType.create([{ action: 'Deploy', impact: -1}, {action: 'Receive', impact: 1}, {action: 'Transfer', impact: 1}])