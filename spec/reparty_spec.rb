require 'spec_helper'

describe Reparty do
  it 'should have a version number' do
    Reparty::VERSION.should_not be_nil
  end

  it 'configures properly' do
    Reparty.config do |config|
      config.sender = 'test@test.com'
    end
    Reparty.configuration.sender.should == 'test@test.com'
  end

  it 'adds reports' do
    Reparty.config do |config|
      config.add_report Reparty::Report, "Some Report"
    end
    Reparty.reports.first.should be_kind_of(Reparty::Report)
    Reparty.reports.first.title.should == "Some Report"
  end
end
