$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'reparty'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}

require 'action_mailer'
ActionMailer::Base.delivery_method = :test