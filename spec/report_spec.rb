require 'spec_helper'

describe Reparty::Report do
  let(:interval) { 1 }
  let(:title) { "title" }

  subject { Reparty::Report.new(interval, title) }

  its(:color)    { should == "#832701"}
  its(:interval) { should == interval}
  its(:title)    { should == title}

  it "requires a title" do
    expect {
      Reparty::Report.new(interval, "")
    }.to raise_exception
  end

  it "has an attach method" do
    expect {
      subject.attach(nil)
    }.to_not raise_exception
  end
end