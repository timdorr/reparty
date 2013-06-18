require "webmock/rspec"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.default_cassette_options  = { :record => :new_episodes }
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true

  c.filter_sensitive_data("<SENDGRID_USER>")     { ENV.fetch("SENDGRID_USER","admin@someplace.com") }
  c.filter_sensitive_data("<SENDGRID_PASSWORD>") { ENV.fetch("SENDGRID_PASSWORD","asdfasdf") }

  c.filter_sensitive_data("<MIXPANEL_FUNNEL>") { ENV.fetch("MIXPANEL_FUNNEL",123456) }
  c.filter_sensitive_data("<MIXPANEL_KEY>")    { ENV.fetch("MIXPANEL_KEY","abc123") }
  c.filter_sensitive_data("<MIXPANEL_SECRET>") { ENV.fetch("MIXPANEL_SECRET","cba321") }
end