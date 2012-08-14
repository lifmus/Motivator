desc "Refund Money"
task :refund_money => :environment do
  # if Time.now.tuesday?
    puts "refunding weekly amounts for goals..."
    User.refund_all_goals_for_previous_week
    puts "...complete."
  # end
end

desc "Charge David"
task :charge_david => :environment do
  user = User.find_by_email('david@example.com')
  user.charge_card(50000, user, user.goals.first)
end