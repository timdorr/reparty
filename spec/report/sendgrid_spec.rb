require_relative '../spec_helper'

describe Reparty::Report::Sendgrid, vcr: { cassette_name: "sendgrid" } do
  let(:sendgrid_user) { ENV.fetch("SENDGRID_USER","admin@someplace.com") }
  let(:sendgrid_pass) { ENV.fetch("SENDGRID_PASSWORD","asdfasdf") }

  let(:stats) { subject.stats(DateTime.new(2013,5,1)) }

  subject do
    Reparty.config do |config|
      config.add_report Reparty::Report::Sendgrid, "Sendgrid Emails", sendgrid_user, sendgrid_pass
    end
    Reparty.reports.last
  end

  it { should be_kind_of(Reparty::Report::Sendgrid) }
  its(:api_user) { should == sendgrid_user }
  its(:api_key)  { should == sendgrid_pass }
  its(:color)    { should == "#287abe" }

  it "gets stats" do
    stats.size.should == 7
    stats.first.should be_kind_of(Hash)
    stats.first["delivered"].should == 3059
  end
end