# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::WikiPages::ShowOperation do
  subject { described_class.(params: {}) }

  let(:wiki_page) { build_stubbed(:wiki_page) }

  before { allow(WikiPage).to receive(:find).and_return(wiki_page)  }

  it "model is the wiki page" do
    expect(subject[:model]).to eq(wiki_page)
  end
end
#
