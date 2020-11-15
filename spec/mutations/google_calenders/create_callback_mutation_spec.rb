# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::CreateCallbackMutation do
  subject(:call) do
    described_class.call(
      organization: organization,
      calendar: calendar,
      google_calendar_authorization_data: google_calendar_authorization_data
    )
  end

  let(:organization) { create(:organization) }
  let(:calendar) { double(id: "calendar_id") }
  let(:google_calendar_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "access_token",
      expires_at: DateTime.parse("10.10.2020 10:10:00"),
      refresh_token: "refresh_token"
    )
  end

  specify do
    expect { call }
      .to change(organization, :google_calendar_id).to("calendar_id")
      .and change(organization, :google_calendar_authorization_data)
      .to(google_calendar_authorization_data)
  end
end
