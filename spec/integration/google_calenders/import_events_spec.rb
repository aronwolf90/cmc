# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Import events" do
  include ActiveJob::TestHelper

  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "ACCESS_TOKEN",
      expires_at: 1.hour.ago.to_datetime,
      refresh_token: ENV["TEST_GOOGLE_CALENDER_REFRESH_TOKEN"] || "test"
    )
  end
  let(:organization) do
    create(:organization, google_authorization_data: google_authorization_data)
  end

  before do
    Timecop.travel "Thu, 23 Jul 2020 22:18:30 +0000"
    allow(Settings.google_calender)
      .to receive(:client_id).and_return(ENV["GOOGLE_CALENDER_CLIENT_ID"])
    allow(Settings.google_calender)
      .to receive(:client_secret).and_return(ENV["GOOGLE_CALENDER_CLIENT_SECRET"])
    allow(Apartment::Tenant).to receive(:switch).and_yield
  end

  after do
    Timecop.return
  end

  specify do
    organization = create(:organization, google_calender_authorization_data: google_authorization_data)
    google_calender = nil
    authorization_data = nil
    google_calender_event = nil

    VCR.use_cassette("google_calenders:integration:import_events:prepare_data") do
      authorization_data = GoogleCalenderClient.authorize!(
        google_authorization_data: google_authorization_data
      )
      google_calender = GoogleCalenderClient.create_calender(
        name: "Test",
        google_authorization_data: authorization_data
      )
      google_calender_event = GoogleCalenderClient.create_event(
        google_calender_id: google_calender.id,
        title: "New event",
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

    VCR.use_cassette("google_calenders:integration:import_events:create_event") do
      perform_enqueued_jobs do
        expect { GoogleCalenders::ImportEventsJob.perform_now(organization) }
          .to change(Event, :count).by(1)
      end
    end

    VCR.use_cassette("google_calenders:integration:import_events:update_event") do
      perform_enqueued_jobs do
        GoogleCalenderClient.update_event(
          google_calender_id: google_calender.id,
          google_calender_event_id: google_calender_event.id,
          title: "Updated event",
          description: "Test",
          start_time: {
            date_time: 1.hour.ago.to_datetime
          },
          end_time: {
            date_time: Time.zone.now.to_datetime
          },
          google_authorization_data: authorization_data
        )
        GoogleCalenders::ImportEventsJob.perform_now(organization)
        expect(Event.last).to have_attributes(title: "Updated event")
      end
    end

    VCR.use_cassette("google_calenders:integration:import_events:destroy_event") do
      perform_enqueued_jobs do
        GoogleCalenderClient.delete_event(
          google_calender_id: google_calender.id,
          google_calender_event_id: google_calender_event.id,
          google_authorization_data: authorization_data
        )
        GoogleCalenders::ImportEventsJob.perform_now(organization)
        expect(Event.unscoped.last.deleted_at).to be_present
      end
    end
  end
end
