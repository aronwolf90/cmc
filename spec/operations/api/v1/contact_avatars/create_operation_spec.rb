# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContactAvatars::CreateOperation do
  subject do
    described_class.(
      params: params,
      current_user: current_user
    )
  end

  let(:file) { Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec", "fixtures", "avatar.png"))) }
  let(:current_user) { Admin.new }
  let(:params) do
    {
      data: {
        file: file
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      "file": file,
    }
  end

  before do
    allow(Api::V1::ContactAvatars::CreateForm)
      .to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::ContactAvatarDeserializer)
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
      params[:data][:file] = nil
      form_result.errors = { data: { file: ["must be filled"] } }
    end

    it "notcall CreateMutation" do
      expect(StandardCreateMutation).not_to receive(:call)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
