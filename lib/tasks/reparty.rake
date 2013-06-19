namespace :reparty do
  desc 'Generate the email to be sent'
  task :email, [:address] => :environment do |t,args|
    unless args.address
      puts "Error: An address is required."
      next
    end

    ReportMailer.daily(args.address).deliver
  end

  desc 'Generate a weekly email to be sent'
  task :weekly_email, [:address] => :environment do |t,args|
    unless args.address
      puts "Error: An address is required."
      next
    end

    ReportMailer.weekly(args.address).deliver
  end
end