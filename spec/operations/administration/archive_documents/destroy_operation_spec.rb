# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveDocuments::DestroyOperation do
  subject { described_class.(params: {}) }

  let(:document) { build_stubbed(:document) }

  before do
    allow(Document).to receive(:find).and_return(document)
  end

  it "call destroy" do
    expect(document).to receive(:destroy!)
    subject
  end
end
