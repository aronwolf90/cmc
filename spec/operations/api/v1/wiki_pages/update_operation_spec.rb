# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::WikiPages::UpdateOperation do
  subject { described_class.(params: params, model: model) }

  let(:model) { build_stubbed(:wiki_page)  }
  let(:params) do
    {
      data: {
        id: 1,
        type: "wiki-pages",
        attributes: {
          title: "new title",
          content: "new content",
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      title: "new title",
      content: "new content",
    }
  end

  before do
    Timecop.freeze
    allow(Api::V1::WikiPages::UpdateForm)
      .to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::WikiPageDeserializer)
      .to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(model).to receive(:update!)
  end

  after do
    Timecop.return
  end

  it "call update!" do
    expect(model).to receive(:update!)
      .with(title: "new title", content: "new content")
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:content] = ""
      form_result.errors = {
        data: { attributes: { content: ["must be filled"] } }
      }
    end

    it "not call update!" do
      expect(model).not_to receive(:update!)
      subject
    end

    it { is_expected.not_to be_success }
  end
end
