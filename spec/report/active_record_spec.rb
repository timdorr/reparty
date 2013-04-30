require_relative '../spec_helper'

describe Reparty::Report::ActiveRecord do
  before(:each) do
    User.delete_all
    [
        {:name => "Someone",   :score => 7, :created_at => DateTime.now - 2},
        {:name => "Sometwo",   :score => 4, :created_at => DateTime.now - 2},
        {:name => "Somethree", :score => 6, :created_at => DateTime.now - 4},
        {:name => "Somefour",  :score => 8, :created_at => DateTime.now - 5},
        {:name => "Somefive",  :score => 2, :created_at => DateTime.now - 6},
        {:name => "Somesix",   :score => 4, :created_at => DateTime.now - 7},
        {:name => "Someseven", :score => 5, :created_at => DateTime.now - 8},
    ].each{|u| User.create!(u) }
  end

  it "configures cleanly" do
    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord, "Users", :user, :count, field: :updated_at
    end
    Reparty.reports.last.should be_kind_of(Reparty::Report::ActiveRecord)
    Reparty.reports.last.field.should == :updated_at
  end

  describe "when configured" do
    subject { Reparty.reports.first }

    before(:each) do
      Reparty.config do |config|
        config.add_report Reparty::Report::ActiveRecord, "Users", :user
      end
    end

    its(:daily_dataset) { should == [1,1,1,1,0,2,0] }
    its(:yesterday)     { should == 0 }
    its(:total)         { should == 7 }

  end

  it "accepts scopes" do
    Reparty.config do |config|
      config.add_report Reparty::Report::ActiveRecord, "Users", User.where("score > 2")
    end

    Reparty.reports.first.daily_dataset.should == [1,0,1,1,0,2,0]
  end
end
