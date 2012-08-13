desc "Refund Money"
task :refund_money => :environment do
  users = Users.where("refund_amount > ?", 0)
  users.each do |user|
    user.refund_charge(params)
    #reset refund amount?
  end
end


desc "Charge David"
task :charge_david => :environment do
  user = User.find_by_email('david@example.com')
  user.charge_card(50000, user, user.goals.first)
end