require_relative '../spec_helper'
require 'action_mailer'
require_relative '../../app/mailers/report_mailer'

describe "reparty:email" do
  include_context "rake"

  before(:each) do
    User.delete_all

    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord, "New User Signups", :user
    end
  end

  its(:prerequisites) { should include("environment") }

  it "requires an address" do
    STDOUT.should_receive(:puts)
    subject.invoke
  end

  it "should generate an email" do
    expect{
      subject.invoke("test@test.com")
    }.to change(ActionMailer::Base, :deliveries)
  end

  it "should send out via letter_opener", letteropener: true do
    require 'letter_opener'
    ActionMailer::Base.add_delivery_method :letter_opener, LetterOpener::DeliveryMethod, :location => File.expand_path('../../../tmp/letter_opener', __FILE__)
    ActionMailer::Base.delivery_method = :letter_opener

    [
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 2},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 2},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 4},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 5},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 6},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 7},
        {:name => "Someone", :score => 1, :created_at => DateTime.now - 8},
    ].each{|u| User.create!(u) }

    Reparty.config do |config|
      config.add_report Reparty::Report::MixpanelFunnel, "Mixpanel Funnel", ENV["MIXPANEL_FUNNEL"], ENV["MIXPANEL_KEY"], ENV["MIXPANEL_SECRET"]
      config.add_report Reparty::Report::ActiveRecord, "New User Signups", :user
      config.add_report Reparty::Report::Sendgrid, "Sendgrid Emails", ENV["SENDGRID_USER"], ENV["SENDGRID_PASSWORD"]
    end

    subject.invoke("test@test.com")
  end
end

describe "reparty:weekly_email" do
  include_context "rake"

  before(:each) do
    User.delete_all

    Reparty.config do |config|
      config.add_weekly_report Reparty::Report::ActiveRecord, "New User Signups", :user
    end
  end

  its(:prerequisites) { should include("environment") }

  it "requires an address" do
    STDOUT.should_receive(:puts)
    subject.invoke
  end

  it "should generate an email" do
    expect{
      subject.invoke("test@test.com")
    }.to change(ActionMailer::Base, :deliveries)
  end
end