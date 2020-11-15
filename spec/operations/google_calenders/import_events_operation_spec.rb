# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ImportEventsOperation do
  subject(:call) do
    described_class.call(organization: organization)
  end

  let(:event) do
    Event.new(
      title: "Title",
      description: "Description",
      google_calendar_event_id: google_calendar_event_id,
      start_time: "10.10.2020 10:10:00",
      end_time: "10.10.2020 10:20:00",
      updated_at: Time.zone.now
    )
  end
  let(:organization) { Organization.new(id: 1, google_calendar_id: "id") }
  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "token",
      expires_at: 1.hour.from_now.to_datetime,
      refresh_token: "refresh_token"
    )
  end
  let(:google_calendar_events) do
    Google::Apis::CalendarV3::Events.new(
      items: [Google::Apis::CalendarV3::Event.new]
    )
  end

  specify do
    expect(GoogleCalendarClient)
      .to receive(:list_events)
      .with(
        "id",
        google_authorization_data: google_authorization_data,
        sync_token: nil
      )
      .and_return(google_calendar_events)
    expect(GoogleCalendars::AuthorizeOperation).to receive(:call)
      .and_return(google_authorization_data: google_authorization_data)
    expect(GoogleCalendars::ImportEventJob).to receive(:perform_later)
    expect(organization).to receive(:update!)
      .with(sync_token: google_calendar_events.next_sync_token)
    call
  end
end
