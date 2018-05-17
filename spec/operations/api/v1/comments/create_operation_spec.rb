# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Comments::CreateOperation do
  subject { described_class.(params: params) }

  let(:params) do
    {
      data: {
        attributes: { content: "comment" },
        relationships: {
          issue: { data: { id: "1", type: "issues" } },
          user: { data: { id: "1", type: "users" } }
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      attributes: {
        content: "comment"
      },
      relationships: {
        issue: { data: { id: 1, type: "issues" } },
        user: { data: { id: 1, type: "users" } }
      }
    }
  end

  before do
    allow(Api::V1::Comments::CreateForm).to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::CommentDeserializer).to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(Comment).to receive(:create!)
  end

  it "call create!" do
    expect(Comment).to receive(:create!).with(deserialized_params)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:attributes][:content] = nil
      form_result.errors = { data: { attributes: { "content": ["must be filled"] } } }
    end

    it "not call create!" do
      expect(Comment).not_to receive(:create!).with(deserialized_params)
    end

    it { is_expected.not_to be_success }
  end
end
