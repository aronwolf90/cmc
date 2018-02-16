# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Comments::CreateTransacion do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          content: "comment"
        },
        relationships: {
          issue: { data: { id: 1, type: "issues" } },
          user: { data: { id: 1, type: "users" } }
        }
      }
    }
  end

  before do
    allow(Api::V1::Comments::CreateForm).to receive(:call).and_return(double("success?": true))
    allow(Api::V1::CommentDeserializer).to receive(:normalize).and_return(content: "comment", user_id: 1, issue_id: 1)
    allow(Comment).to receive(:create!)
  end

  it "correct classes have been called" do
    expect(Api::V1::Comments::CreateForm).to receive(:call)
    expect(Api::V1::CommentDeserializer).to receive(:normalize)
    expect(Comment).to receive(:create!)

    subject
  end
end
