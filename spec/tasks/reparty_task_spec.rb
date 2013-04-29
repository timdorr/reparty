require_relative '../spec_helper'
require 'action_mailer'
require_relative '../../app/mailers/report_mailer'

describe "reparty:email" do
  include_context "rake"

  before(:each) do
    class User
      def self.count(field=nil)
        2
      end
    end

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

    subject.invoke("test@test.com")
  end
end