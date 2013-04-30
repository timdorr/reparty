require 'spec_helper'

describe Reparty::Email do
  describe "provides variables" do
    let(:klass) { subject.class }

    let(:from)  { "test@test.com" }
    let(:subj)  { "Test Subject" }
    let(:title) { "Test Title" }

    before do
      Reparty.config do |config|
        config.from = from
        config.subject = subj
        config.title = title
      end
    end

    it { klass.from.should eq(from) }
    it { klass.subject.should eq(subj) }
    it { klass.title.should eq(title) }
    it { klass.reports.should be_empty }
  end
end