# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "j@j.com", :password => '123456', :password_confirmation => '123456')
goal = Goal.new(:description => 'test goal', :due_date => 2.months.from_now)
goal.user = user
goal.save

goal.objectives.create(:frequency => 3, :description => 'blah')