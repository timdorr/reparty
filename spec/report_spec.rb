require 'spec_helper'

describe Reparty::Report do
  subject { Reparty::Report.new("title") }

  its(:color) { should == "#832701"}

  it "requires a title" do
    expect {
      Reparty::Report.new("title!")
    }.to_not raise_exception

    expect {
      Reparty::Report.new(nil)
    }.to raise_exception

    expect {
      Reparty::Report.new("")
    }.to raise_exception
  end

  it "has an attach method" do
    expect {
      Reparty::Report.new("title!").attach(nil)
    }.to_not raise_exception
  end
end