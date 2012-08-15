desc "Send reminder to users about objectives"
task :send_reminder => :environment do
    puts "finding all users.."
    users = User.all
    puts "sending sms to all users"
    users.each { |user| user.send_text_reminder }
    puts "...complete."
end