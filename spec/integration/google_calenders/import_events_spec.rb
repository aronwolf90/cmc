# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Import events" do
  include ActiveJob::TestHelper

  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "ACCESS_TOKEN",
      expires_at: 1.hour.ago.to_datetime,
      refresh_token: "REFRESH_TOKEN"
    )
  end
  let(:organization) do
    create(:organization, google_authorization_data: google_authorization_data)
  end

  before do
    allow(Apartment::Tenant).to receive(:switch).and_yield
  end

  specify do
    organization = create(:organization, google_calender_authorization_data: google_authorization_data)
    google_calender = nil

    VCR.use_cassette("google_calenders:integration:import_events:prepare_data") do
      authorization_data = GoogleCalenderClient.authorize!(
        google_authorization_data: google_authorization_data
      )
      google_calender = GoogleCalenderClient.create_calender(
        name: "Test",
        google_authorization_data: authorization_data
      )
      GoogleCalenderClient.create_event(
        google_calender_id: google_calender.id,
        title: "Test",
        description: "Test",
        start_time: {
          date_time: 1.hour.ago.to_datetime
        },
        end_time: {
          date_time: Time.zone.now.to_datetime
        },
        google_authorization_data: authorization_data
      )
    end

    organization.update!(google_calender_id: google_calender.id)

    VCR.use_cassette("google_calenders:integration:import_events:run") do
      perform_enqueued_jobs do
        expect { GoogleCalenders::ImportEventsJob.perform_now(organization) }
          .to change(Event, :count).by(1)
        expect(Event.last).to have_attributes(title: "Test")
      end
    end
  end
end
