# frozen_string_literal: true

require "rails_helper"

RSpec.describe Document, type: :model do
  it { is_expected.to belong_to :folder }
  it { is_expected.to belong_to :document_file }

  context "when name is blank" do
    subject { create(:document, name: nil) }

    specify do
      expect { subject }
        .to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  context "when folder is nil" do
    subject { create(:document, folder_id: nil) }

    specify do
      expect { subject }
        .to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  describe "#download_name" do
    subject do
      create(:document, name: "document name")
    end

    it { expect(subject.download_name).to eq("document_name.txt") }
  end
end
