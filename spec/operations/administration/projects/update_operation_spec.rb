# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::UpdateOperation do
  subject { described_class.(params: params) }

  let(:project) { build_stubbed(:project) }

  before do
    allow(Administration::ProjectForm)
      .to receive(:new).and_return(form)
    allow(form).to receive(:save).and_return(true)
    allow(Project).to receive(:find).and_return(project)
  end

  context "valid params" do
    let(:params) do
      {
        data: {
          name: "name"
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
          name: nil
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
