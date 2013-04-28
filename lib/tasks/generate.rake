namespace :reparty do
  desc 'Generate the email to be sent'
  task :email, [:address] => :environment do |t,args|
    unless args.address
      puts "Error: An address is required."
      next
    end

    ActionMailer::Base.delivery_method = :letter_opener
    ReportMailer.daily(args.address).deliver
  end
end