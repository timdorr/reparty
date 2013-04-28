namespace :reparty do
  desc 'Generate the email to be sent'
  task :email, [:address] => :environment do |t,args|
    unless args.user_id
      puts "Error: An address is required."
      next
    end
  end
end