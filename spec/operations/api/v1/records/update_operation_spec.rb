# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Records::UpdateOperation do
  subject { described_class.(params: params, model: record, current_user: current_user) }

  let(:record) { build_stubbed(:record) }
  let(:current_user) { build_stubbed(:user) }
  let(:params) do
    {
      data: {
        id: 1,
        type: "records",
        attributes: {
          "start-time": Time.zone.now,
          "end-time": 1.hour.from_now,
          "complexity": "0.5"
        },
        relationships: {
          user: { data: { id: 1, type: "users" } },
          issue: { data: { id: 1, type: "issues" } }
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      start_time: Time.zone.now,
      end_time: 1.hour.from_now,
      user_id: 1,
      issue_id: 1
    }
  end

  before do
    Timecop.freeze
    allow(Api::V1::Records::UpdateForm).to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::RecordDeserializer).to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(Records::UpdateMutation).to receive(:call)
      .with(record, attributes: deserialized_params, current_user: current_user).and_return(build_stubbed(:record, deserialized_params))
  end

  after do
    Timecop.return
  end

  it "call UpdateMutation" do
    expect(Records::UpdateMutation).to receive(:call)
      .with(record, attributes: deserialized_params, current_user: current_user)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:"start-time"] = nil
      form_result.errors = {
        data: { attributes: { "start-time": ["must be filled"] } }
      }
    end

    it "not call UpdateMutation" do
      expect(Records::UpdateMutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
