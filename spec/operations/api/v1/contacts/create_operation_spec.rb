# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Contacts::CreateOperation do
  subject do
    described_class.(
      params: params,
      current_user: current_user
    )
  end

  let(:current_user) { Admin.new }
  let(:params) do
    {
      data: {
        id: 1,
        type: "contacts",
        attributes: {
          "lastname": "Name",
          "name": "Frantz",
          "kind": "person",
          "address_city": "Augsburg",
          "address_zip": "86153",
          "address_country": "germany",
          "address_steet": "Street",
          "address_number": "8"
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      "lastname": "Name",
      "name": "Frantz",
      "kind": "person",
      "address_city": "Augsburg",
      "address_zip": "86153",
      "address_country": "germany",
      "address_steet": "Street",
      "address_number": "8"
    }
  end

  before do
    allow(Api::V1::Contacts::CreateForm)
      .to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::ContactDeserializer)
      .to receive(:call)
      .with(params[:data]).and_return(deserialized_params)
    allow(StandardCreateMutation).to receive(:call)
  end

  it "call CreateMutation" do
    expect(StandardCreateMutation).to receive(:call)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:content] = nil
      form_result.errors = { data: { attributes: { "content": ["must be filled"] } } }
    end

    it "notcall CreateMutation" do
      expect(StandardCreateMutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
