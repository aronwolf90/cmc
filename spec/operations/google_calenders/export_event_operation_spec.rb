# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ExportEventOperation do
  subject(:call) do
    described_class.call(event: event, organization: organization)
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
  let(:organization) { Organization.new(google_calendar_id: "id") }
  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "token",
      expires_at: 1.hour.from_now.to_datetime,
      refresh_token: "refresh_token"
    )
  end
  let(:google_calendar_event) do
    Google::Apis::CalendarV3::Event.new(id: "id", updated: 1.hour.ago)
  end

  before do
    allow(event).to receive(:update!)
    allow(GoogleCalendarClient).to receive(:create_event).and_return(google_calendar_event)
    allow(GoogleCalendarClient).to receive(:update_event).and_return(google_calendar_event)
    allow(GoogleCalendarClient).to receive(:get_event).and_return(google_calendar_event)
    allow(GoogleCalendarClient).to receive(:authorize!).and_return(google_authorization_data)
    allow(GoogleCalendars::AuthorizeOperation).to receive(:call)
      .and_return(google_authorization_data: google_authorization_data)
  end

  context "when Event#google_calendar_event_id is nil" do
    let(:google_calendar_event_id) { nil }

    specify do
      call
      expect(GoogleCalendarClient).to have_received(:create_event)
        .with(
          google_calendar_id: "id",
          title: "Title",
          description: "Description",
          start_time: {
            date_time: "10.10.2020 10:10:00".to_time.rfc3339
          },
          end_time: {
            date_time: "10.10.2020 10:20:00".to_time.rfc3339
          },
          google_authorization_data: organization.google_calendar_authorization_data
      )
    end
  end

  context "when Event#google_calendar_event_id is present" do
    let(:google_calendar_event_id) { "event_id" }

    specify do
      call
      expect(GoogleCalendarClient).to have_received(:update_event)
        .with(
          google_calendar_id: "id",
          google_calendar_event_id: "event_id",
          title: "Title",
          description: "Description",
          start_time: {
            date_time: "10.10.2020 10:10:00".to_time.rfc3339
          },
          end_time: {
            date_time: "10.10.2020 10:20:00".to_time.rfc3339
          },
          google_authorization_data: organization.google_calendar_authorization_data
      )
    end
  end

  context "when Event#google_calendar_event_id is present and updated is in the future" do
    let(:google_calendar_event_id) { "event_id" }

    before do
      allow(GoogleCalendarClient).to receive(:get_event).and_return(double(id: "id", updated: 1.hour.from_now, status: nil))
    end

    specify do
      call
      expect(GoogleCalendarClient).not_to have_received(:update_event)
    end
  end

  context "when the event was deleted" do
    let(:event) do
      Event.new(deleted_at: Time.zone.now, google_calendar_event_id: "id", updated_at: Time.zone.now)
    end

    before do
      allow(GoogleCalendarClient)
        .to receive(:get_event).and_return(double(id: "id", updated: 1.hour.ago, status: nil))
    end

    specify do
      expect(GoogleCalendarClient).to receive(:delete_event)
      call
    end
  end

  context "when Google::Apis::ClientError is raiced" do
    let(:event) do
      Event.new(deleted_at: Time.zone.now, google_calendar_event_id: "id", updated_at: Time.zone.now)
    end

    before do
      allow(GoogleCalendarClient)
        .to receive(:get_event).and_raise(Google::Apis::ClientError.new(nil))
    end

    specify do
      expect(event).not_to receive(:update!)
      expect(GoogleCalendarClient).not_to have_received(:update_event)
      expect(GoogleCalendarClient).not_to have_received(:create_event)
      call
    end
  end
end
