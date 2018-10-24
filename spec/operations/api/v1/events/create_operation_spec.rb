# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Events::CreateOperation do
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
        attributes: {
          "start-time": Time.zone.now,
          "all-day": true
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      start_time: Time.zone.now,
      all_day: true
    }
  end

  before do
    allow(Api::V1::Events::CreateForm).to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::EventDeserializer).to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(StandardCreateMutation).to receive(:call)
  end

  it "call CreateMutation" do
    expect(StandardCreateMutation).to receive(:call)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:"start-time"] = nil
      form_result.errors = { data: { attributes: { "start-time": ["must be filled"] } } }
    end

    it "notcall CreateMutation" do
      expect(StandardCreateMutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
