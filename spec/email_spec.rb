require 'spec_helper'

describe Reparty::Email do
  describe "provides variables" do
    let(:from)    { "test@test.com" }
    let(:subject) { "Test Subject" }
    let(:title)   { "Test Title" }

    before do
      Reparty.config do |config|
        config.from = from
        config.subject = subject
        config.title = title
      end
    end

    it {    from.should eq(from) }
    it { subject.should eq(subject) }
    it {   title.should eq(title) }
  end
end