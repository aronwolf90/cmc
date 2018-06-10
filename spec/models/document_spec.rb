# frozen_string_literal: true

require "rails_helper"

RSpec.describe Document, type: :model do
  it { is_expected.to belong_to :folder  }

  context "when name is blank" do
    subject { create(:document, name: nil)  }

    it { expect { subject }.to raise_error(ActiveRecord::NotNullViolation) }
  end

  context "when folder is nil" do
    subject { create(:document, folder_id: nil)  }

    it { expect { subject }.to raise_error(ActiveRecord::NotNullViolation) }
  end

  describe "#download_name" do
    subject { create(:document, name: "document name")  }

    it { expect(subject.download_name).to eq("document_name.txt") }
  end
end
