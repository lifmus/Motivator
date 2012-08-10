desc "Refund Money"
task :refund_money => :environment do
  users = Users.where("refund_amount > ?", 0)
  users.each do |user|
    user.refund_charge(params)
    #reset refund amount?
  end
end


desc "Charge TJ"
task :charge_TJ => :environment do
  user = User.find_by_email('teej.murphy@gmail.com')
  user.charge_card(50000, user, user.goals.first)
end