# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveDocuments::CreateOperation do
  subject { described_class.(params: params) }

  before do
    allow(Administration::ArchiveDocumentForm)
      .to receive(:new).and_return(form)
    allow(form).to receive(:save).and_return(true)
  end

  context "valid params" do
    let(:params) do
      {
        data: {
          name: "title",
          folder_id: 1
        }
      }
    end
    let(:form) { double()  }

    before do
      allow(form).to receive(:call).and_return(double(success?: true))
    end

    it { is_expected.to be_success }

    it do
      subject
      expect(form).to have_received(:save)
    end
  end

  context "invalid params" do
    let(:params) do
      {
        data: {
          anem: nil
        }
      }
    end
    let(:form) { double()  }

    before do
      allow(form).to receive(:call).and_return(double(success?: false))
    end

    it { is_expected.to be_failure }

    it do
      subject
      expect(form).not_to have_received(:save)
    end
  end
end
