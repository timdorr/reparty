require "webmock/rspec"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.default_cassette_options  = { :record => :new_episodes }
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<SENDGRID_USER>")     { ENV.fetch("SENDGRID_USER","admin@someplace.com") }
  c.filter_sensitive_data("<SENDGRID_PASSWORD>") { ENV.fetch("SENDGRID_PASSWORD","asdfasdf") }
end