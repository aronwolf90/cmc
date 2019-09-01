# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContactAvatarSerializer, type: :serializer do
  let(:contact_avatar) { build_stubbed(:contact_avatar) }

  let(:expected_result) do
    {
      data: {
        id: contact_avatar.id.to_s,
        type: "contact-avatars",
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(contact_avatar)).to eql expected_result
  end
end
