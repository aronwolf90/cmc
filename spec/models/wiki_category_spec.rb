# frozen_string_literal: true

require "rails_helper"

RSpec.describe WikiCategory, type: :model do
  it { is_expected.to belong_to :wiki_category }
  it { is_expected.to have_many :wiki_categories }
  it { is_expected.to have_many :wiki_pages }

  describe "#root?" do
    context "has no parent wiki category" do
      subject { build_stubbed(:wiki_category, wiki_category: nil)  }

      it { is_expected.to be_root }
    end

    context "has a parent wiki category" do
      subject { build_stubbed(:wiki_category, wiki_category: build_stubbed(:wiki_category)) }

      it { is_expected.not_to be_root }
    end
  end

  describe "#to_s" do
    subject { build_stubbed(:wiki_category, title: "title")  }

    it { expect(subject.to_s).to eq "title" }
  end
end
