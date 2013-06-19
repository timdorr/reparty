require 'spec_helper'

describe Reparty do
  it "should have a version number" do
    Reparty::VERSION.should_not be_nil
  end

  it "configures properly" do
    Reparty.config do |config|
      config.sender = "test@test.com"
    end
    Reparty.configuration.sender.should == "test@test.com"
  end

  describe "adds reports" do
    subject do
      Reparty.config do |config|
        config.add_report Reparty::Report, "Some Report"
        config.add_weekly_report Reparty::Report, "Some Weekly Report"
      end
      Reparty
    end

    its("reports.first")       { should be_kind_of(Reparty::Report) }
    its("reports.first.title") { should == "Some Report" }
    its("reports.size")        { should == 1 }

    its("weekly_reports.first")       { should be_kind_of(Reparty::Report) }
    its("weekly_reports.first.title") { should == "Some Weekly Report" }
    its("weekly_reports.size")        { should == 1 }
  end
end
