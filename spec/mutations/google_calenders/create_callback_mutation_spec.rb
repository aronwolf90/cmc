# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::CreateCallbackMutation do
  subject(:call) do
    described_class.call(
      organization: organization,
      calender: calender,
      google_calender_authorization_data: google_calender_authorization_data
    )
  end

  let(:organization) { create(:organization) }
  let(:calender) { double(id: "calender_id") }
  let(:google_calender_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "access_token",
      expires_at: DateTime.parse("10.10.2020 10:10:00"),
      refresh_token: "refresh_token"
    )
  end

  specify do
    expect { call }
      .to change(organization, :google_calender_id).to("calender_id")
      .and change(organization, :google_calender_authorization_data)
      .to(google_calender_authorization_data)
  end
end
