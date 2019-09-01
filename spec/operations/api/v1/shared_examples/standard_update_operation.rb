# frozen_string_literal: true

RSpec.shared_examples "standard api update operation" do
  |
    form:,
    deserializer:,
    model:,
    valid_params: { data: {} },
    invalid_params: { data: {} },
    deserialized_params: {},
    current_user: Admin.new,
    errors: ["erros"],
    mutation: StandardUpdateMutation
  |
  subject do
    described_class.(
      params: params,
      current_user: current_user
    )
  end

  before do
    allow(model.class).to receive(:find).and_return(model)
    allow(form).to receive(:call).and_return(form_result)
    allow(deserializer)
      .to receive(:call)
      .with(params[:data]).and_return(deserialized_params)
    allow(mutation).to receive(:call)
  end

  context "when params are valid" do
    let(:form_result) { OpenStruct.new(errors: []) }
    let(:params) { valid_params }
    let(:result) { double(errors: []) }

    it "call UpdateMutation" do
      expect(mutation).to receive(:call)
      subject
    end

    it { is_expected.to be_success }
  end

  context "when params are invalid" do
    let(:form_result) { OpenStruct.new(errors: errors) }
    let(:params) { invalid_params }

    it "not call UpdateMutation" do
      expect(mutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
