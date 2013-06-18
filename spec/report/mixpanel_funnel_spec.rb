require_relative '../spec_helper'

describe Reparty::Report::MixpanelFunnel, vcr: { cassette_name: "mixpanel" } do
  let(:funnel_id)       { ENV.fetch("MIXPANEL_FUNNEL", 123456) }
  let(:mixpanel_key)    { ENV.fetch("MIXPANEL_KEY",    "abc123") }
  let(:mixpanel_secret) { ENV.fetch("MIXPANEL_SECRET", "cba321") }

  subject do
    Reparty.config do |config|
      config.add_report Reparty::Report::MixpanelFunnel, "Mixpanel Funnel", funnel_id, mixpanel_key, mixpanel_secret
    end
    Reparty.reports.last
  end

  it { should be_kind_of(Reparty::Report::MixpanelFunnel) }
  its(:funnel_id)  { should == funnel_id }
  its(:api_key)    { should == mixpanel_key }
  its(:api_secret) { should == mixpanel_secret }
  its(:color)      { should == "#7548a2" }
  its(:client)     { should be_kind_of(Mixpanel::Client)}

  its("funnel_data.size") { should == 7 }
end