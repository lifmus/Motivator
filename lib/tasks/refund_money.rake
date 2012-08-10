desc "Refund Money"
task :refund_money => :environment do
  users = Users.where("refund_amount > ?", 0)
  users.each do |user|
    user.refund_charge(params)
    #reset refund amount?
  end
end