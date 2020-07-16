# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ExportEventOperation do
  subject(:call) do
    described_class.call(event: event, organization: organization)
  end

  let(:event) do
    Event.new(
      title: "Title",
      description: "Description",
      google_calender_event_id: google_calender_event_id,
      start_time: "10.10.2020 10:10:00",
      end_time: "10.10.2020 10:20:00",
      updated_at: Time.zone.now
    )
  end
  let(:organization) { Organization.new(google_calender_id: "id") }
  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "token",
      expires_at: 1.hour.from_now.to_datetime,
      refresh_token: "refresh_token"
    )
  end

  before do
    allow(GoogleCalenderClient).to receive(:create_event).and_return(double(id: "id"))
    allow(GoogleCalenderClient).to receive(:update_event).and_return(double(id: "id"))
    allow(GoogleCalenderClient).to receive(:get_event).and_return(double(id: "id", updated: 1.hour.ago))
    allow(GoogleCalenderClient).to receive(:authorize!).and_return(google_authorization_data)
    allow(GoogleCalenders::AuthorizeOperation).to receive(:call)
      .and_return(google_authorization_data: google_authorization_data)
  end

  context "when Event#google_calender_event_id is nil" do
    let(:google_calender_event_id) { nil }

    specify do
      call
      expect(GoogleCalenderClient).to have_received(:create_event)
        .with(
          google_calender_id: "id",
          title: "Title",
          description: "Description",
          start_time: {
            date_time: "10.10.2020 10:10:00".to_time.rfc3339
          },
          end_time: {
            date_time: "10.10.2020 10:20:00".to_time.rfc3339
          },
          google_authorization_data: organization.google_calender_authorization_data
      )
    end
  end

  context "when Event#google_calender_event_id is present" do
    let(:google_calender_event_id) { "event_id" }

    specify do
      call
      expect(GoogleCalenderClient).to have_received(:update_event)
        .with(
          google_calender_id: "id",
          google_calender_event_id: "event_id",
          title: "Title",
          description: "Description",
          start_time: {
            date_time: "10.10.2020 10:10:00".to_time.rfc3339
          },
          end_time: {
            date_time: "10.10.2020 10:20:00".to_time.rfc3339
          },
          google_authorization_data: organization.google_calender_authorization_data
      )
    end
  end

  context "when Event#google_calender_event_id is present and updated is in the future" do
    let(:google_calender_event_id) { "event_id" }

    before do
      allow(GoogleCalenderClient).to receive(:get_event).and_return(double(id: "id", updated: 1.hour.from_now))
    end

    specify do
      call
      expect(GoogleCalenderClient).not_to have_received(:update_event)
    end
  end
end
