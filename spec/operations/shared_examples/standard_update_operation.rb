# frozen_string_literal: true

RSpec.shared_examples "standard update operation" do
  |form_class, valid_params, invalid_params|

  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:current_user) { build_stubbed(:admin) }

  before do
    allow(form_class)
      .to receive(:new).and_return(form)
    allow(form).to receive(:save).and_return(true)
  end

  context "valid params" do
    let(:params) { valid_params }
    let(:form) { double() }

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
    let(:params) { invalid_params }
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
