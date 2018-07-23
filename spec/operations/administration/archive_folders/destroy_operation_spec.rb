# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveFolders::DestroyOperation do
  subject { described_class.(params: {}) }

  let(:folder) { build_stubbed(:folder) }

  before do
    allow(Folder).to receive(:find).and_return(folder)
  end

  it "call destroy" do
    expect(folder).to receive(:destroy!)
    subject
  end
end
