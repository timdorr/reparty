require_relative '../spec_helper'

describe "Reparty::Report::ActiveRecord" do
  it 'configures cleanly' do
    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord
    end
    Reparty.reports.first.should be_kind_of(Reparty::Report::ActiveRecord)
  end

  it 'implements run' do
    expect{
      Reparty::Report::ActiveRecord.new.run
    }.to_not raise_exception
  end
end
