require_relative '../spec_helper'

interval_matcher = lambda do |request_made, request_stored|
  CGI.parse(URI(request_made.uri).query).fetch("interval",nil) == CGI.parse(URI(request_stored.uri).query).fetch("interval",nil)
end

describe Reparty::Report::Mixpanel, vcr: { cassette_name: "mixpanel", match_requests_on: [:method, :host, :path, interval_matcher] } do
  let(:funnel_id)       { ENV.fetch("MIXPANEL_FUNNEL", 123456) }
  let(:mixpanel_key)    { ENV.fetch("MIXPANEL_KEY",    "abc123") }
  let(:mixpanel_secret) { ENV.fetch("MIXPANEL_SECRET", "cba321") }

  subject do
    Reparty.config do |config|
      config.add_report Reparty::Report::Mixpanel, "Mixpanel Funnel", mixpanel_key, mixpanel_secret, :funnel, funnel_id
    end
    Reparty.reports.last
  end

  it { should be_kind_of(Reparty::Report::Mixpanel) }
  its(:report)     { should == :funnel }
  its(:api_key)    { should == mixpanel_key }
  its(:api_secret) { should == mixpanel_secret }
  its(:color)      { should == "#7548a2" }
  its(:client)     { should be_kind_of(Mixpanel::Client)}

  its("funnel_data.size") { should == 7 }

  describe "weekly interval support" do
    subject do
      Reparty.config do |config|
        config.add_weekly_report Reparty::Report::Mixpanel, "Mixpanel Funnel", mixpanel_key, mixpanel_secret, :funnel, funnel_id
      end
      Reparty.weekly_reports.last
    end

    its("funnel_data.size") { should == 7 }
  end

  describe "engagement report" do
    subject do
      Reparty.config do |config|
        config.add_weekly_report Reparty::Report::Mixpanel, "Mixpanel Funnel", mixpanel_key, mixpanel_secret, :engage, ["crm", "pro"]
      end
      Reparty.weekly_reports.last
    end

    its(:fields) { should == ["crm", "pro"] }
    its("engage_data.size") { should == 54 }
  end
end