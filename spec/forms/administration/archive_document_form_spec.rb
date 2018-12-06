# frozen_string_literal: true

require "rails_helper"

describe Administration::ArchiveDocumentForm do
  subject { described_class.new(document) }

  let(:document) { build_stubbed(:document) }
  let(:folder) { document.folder }

  before do
    allow(document).to receive(:file).and_return double(original_filename: "test.txt")
  end

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(name: nil)).to be false }
  it { expect(subject.validate(folder_id: nil)).to be false }

  context "when the document is not present" do
    before do
      allow(document).to receive(:file).and_return double(file: nil)
    end

    it { expect(subject.validate({})).to be false }
  end

  it "call, success" do
    expect(subject.call({}).success?).to eq true
  end
end
