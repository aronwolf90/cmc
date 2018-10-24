# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Events::UpdateOperation do
  subject do
    described_class.(
      params: params,
      current_user: user
    )
  end

  let(:user) { Admin.new }
  let(:event) { Event.new }
  let(:params) do
    {
      data: {
        id: "1",
        type: "events",
        attributes: { title: "New title" }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      title: "New title",
    }
  end

  before do
    allow(Event).to receive(:find).and_return(event)
    allow(Api::V1::Events::UpdateForm).to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::EventDeserializer).to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(event).to receive(:update!)
  end

  it "call update!" do
    expect(event).to receive(:update!).with(deserialized_params)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:id] = nil
      form_result.errors = {
        data: { id: ["must be filled"] }
      }
    end

    it "not call update!" do
      expect(event).not_to receive(:update!).with(deserialized_params)
    end

    it { is_expected.not_to be_success }
  end
end
