require_relative '../spec_helper'

describe "Reparty::Report::ActiveRecord" do
  before(:each) do
    class User
      def self.count
        2
      end
    end
  end

  it 'configures cleanly' do
    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord, "Users", :user
    end
    Reparty.reports.last.should be_kind_of(Reparty::Report::ActiveRecord)
  end
end
