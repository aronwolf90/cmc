# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::WikiCategories::DestroyOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:wiki_category) { build_stubbed(:wiki_category) }
  let(:user) { build_stubbed(:admin)  }

  before do
    allow(WikiCategory).to receive(:find).and_return(wiki_category)
  end

  it "call destroy" do
    expect(wiki_category).to receive(:destroy!)
    subject
  end
end
