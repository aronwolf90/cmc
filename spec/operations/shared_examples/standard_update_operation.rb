# frozen_string_literal: true

RSpec.shared_examples "standard update operation" do
  |
    form_class:,
    valid_params: { data: {} },
    invalid_params: { data: {} },
    mutation: StandardUpdateMutation
  |

  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:current_user) { build_stubbed(:admin) }

  before do
    allow(form_class)
      .to receive(:new).and_return(form)
    allow(model.class).to receive(:find).and_return(model)
  end

  context "valid params" do
    let(:params) { valid_params }
    let(:form) { double() }
    let(:result) { double(success?: true) }

    before do
      allow(form).to receive(:call).and_return(result)
      allow(result).to receive(:save).and_yield(params[:data])
      allow(mutation).to receive(:call)
      allow(result).to receive(:validate).and_return(true)
    end

    it { is_expected.to be_success }

    it do
      expect(mutation).to receive(:call)
      subject
    end
  end

  context "invalid params" do
    let(:params) { invalid_params }
    let(:form) { double() }
    let(:result) { double(success?: false) }

    before do
      allow(form).to receive(:call).and_return(result)
    end

    it { is_expected.to be_failure }

    it do
      expect(mutation).not_to receive(:call)
      subject
    end
  end
end
