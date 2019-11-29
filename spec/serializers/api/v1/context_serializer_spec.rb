# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContextSerializer, type: :serializer do
  let(:user) { build_stubbed(:user) }
  let(:context) { Context.new(current_user: user, premium: true, user_count: 1) }

  let(:expected_result) do
    {
      data: {
        id: "context",
        type: "contexts",
        attributes: {
          premium: true,
          "user-count": 1
        },
        relationships: {
          "current-user": { data: { id: user.id.to_s, type: "users" } }
        }
      }
    }
  end

  it "serialize context in the correct way" do
    expect(serialize(context)).to eq expected_result
  end
end
