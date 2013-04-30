require_relative '../spec_helper'

describe "Reparty::Report::ActiveRecord" do
  before(:each) do
    User.delete_all
  end

  it 'configures cleanly' do
    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord, "Users", :user, :count, field: :updated_at
    end
    Reparty.reports.last.should be_kind_of(Reparty::Report::ActiveRecord)
    Reparty.reports.last.field.should == :updated_at
  end
end
