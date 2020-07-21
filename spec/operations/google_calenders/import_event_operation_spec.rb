# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ImportEventOperation do
  subject(:call) do
    described_class.(
      google_calender_event: google_calender_event,
      organization: organization
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
  let(:event) { Event.new }
  let(:google_calender_event) do
    double(
      id: "id",
      updated: 1.hour.ago,
      summary: "Title",
      start: double(date_time: 1.hour.ago),
      end: double(date_time: 1.hour.from_now),
      description: "description"
    )
  end

  before do
    allow(GoogleCalenderClient)
      .to receive(:get_event)
      .and_return(double(
                    id: "id",
                    updated: 1.hour.ago,
                    summary: "Title",
                    start: double(date_time: 1.hour.ago),
                    end: double(date_time: 1.hour.from_now),
                    description: "description"
      )
    )
    allow(GoogleCalenders::AuthorizeOperation).to receive(:call)
      .and_return(google_authorization_data: google_authorization_data)
    allow(Event).to receive(:find_or_initialize_by).and_return(event)
  end

  context "when Event#google_calender_event_id is nil" do
    let(:google_calender_event_id) { nil }

    specify do
      expect(event).to receive(:update!)
      call
    end
  end
end
