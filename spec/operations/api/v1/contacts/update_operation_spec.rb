# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Contacts::UpdateOperation do
  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:record) { Contact.new }
  let(:current_user) { Admin.new }
  let(:params) do
    {
      data: {
        id: 1,
        type: "contacts",
        attributes: {
          "lastname": "New name"
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      "lastname": "New name"
    }
  end

  before do
    allow(Contact).to receive(:find).and_return(record)
    allow(Api::V1::Contacts::UpdateForm)
      .to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::ContactDeserializer)
      .to receive(:call)
      .with(params[:data]).and_return(deserialized_params)
    allow(StandardUpdateMutation).to receive(:call)
  end

  it "call UpdateMutation" do
    expect(StandardUpdateMutation).to receive(:call)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:kind] = nil
      form_result.errors = {
        data: { attributes: { "kind": ["must be filled"] } }
      }
    end

    it "not call UpdateMutation" do
      expect(StandardUpdateMutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
