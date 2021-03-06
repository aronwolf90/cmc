# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::UserAvatarSerializer, type: :serializer do
  let(:user_avatar) { UserAvatar.new(id: 1) }

  let(:expected_result) do
    {
      data: {
        id: user_avatar.id.to_s,
        type: "user-avatars",
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(user_avatar)).to eql expected_result
  end
end
