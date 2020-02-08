# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::NotificationSerializer, type: :serializer do
  let(:notification) do
    Notification.new(
      id: 1,
      subject: "Notifications subject",
      body: "Notifications body"
    )
  end
  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "notifications",
        attributes: {
          subject: "Notifications subject",
          body: "Notifications body"
        }
      }
    }
  end

  it "serialize notification in the correct way" do
    expect(serialize(notification)).to eql expected_result
  end
end
