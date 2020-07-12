# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ExportEventOperation do
  subject(:call) do
    described_class.call(event: event)
  end

  let(:event) do
    Event.new(
      title: "Title",
      description: "Description",
      google_calender_event_id: google_calender_event_id,
      start_time: "10.10.2020 10:10:00",
      end_time: "10.10.2020 10:20:00"
    )
  end
  let(:organization) { Organization.new(google_calender_id: "id") }

  before do
    allow(GoogleCalenderClient).to receive(:create_event).and_return(double(id: "id"))
    allow(GoogleCalenderClient).to receive(:update_event).and_return(double(id: "id"))
    allow(Organization).to receive(:current).and_return(organization)
  end

  context "when Event#google_calender_event_id is present" do
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

  context "when Event#google_calender_event_id is nil" do
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
end
