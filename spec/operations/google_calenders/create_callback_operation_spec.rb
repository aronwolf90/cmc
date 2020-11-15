# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe GoogleCalendars::CreateCallbackOperation do
  let(:calendar) { double(id: "test") }
  let(:organization) { Organization.new(id: 1, name: "test-name") }
  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "access_token",
      expires_at: DateTime.parse("10.10.2020 10:10:00"),
      refresh_token: "refresh_token"
    )
  end

  before do
    allow(GoogleCalendarClient)
      .to receive(:get_access_token).and_return(google_authorization_data)
    allow(GoogleCalendarClient)
      .to receive(:create_calendar).and_return(calendar)
    allow(GoogleCalendars::CreateCallbackMutation).to receive(:call)
    allow(GoogleCalendarClient).to receive(:watch)
  end

  context "when web_hook is disabled" do
    before do
      allow(Settings.google_calendar).to receive(:web_hook).and_return(false)
    end

    specify do
      result = described_class.call(organization: organization, code: "code")

      expect(GoogleCalendarClient)
        .to have_received(:create_calendar)
        .with(name: "test-name", google_authorization_data: google_authorization_data)
      expect(GoogleCalendars::CreateCallbackMutation)
        .to have_received(:call)
        .with(
          organization: organization,
          calendar: calendar,
          google_calendar_authorization_data: google_authorization_data
        )
      expect(GoogleCalendarClient).not_to have_received(:watch)
      expect(result[:organization]).to eq(organization)
    end
  end

  context "when web_book is enabled" do
    before do
      allow(Settings.google_calendar).to receive(:web_hook).and_return(true)
    end

    specify do
      result = described_class.call(organization: organization, code: "code")

      expect(GoogleCalendarClient)
        .to have_received(:create_calendar)
        .with(name: "test-name", google_authorization_data: google_authorization_data)
      expect(GoogleCalendars::CreateCallbackMutation)
        .to have_received(:call)
        .with(
          organization: organization,
          calendar: calendar,
          google_calendar_authorization_data: google_authorization_data
        )
      expect(GoogleCalendarClient)
        .to have_received(:watch)
        .with(
          google_calendar_id: "test",
          google_authorization_data: google_authorization_data,
          url: "https://lvh.me:3000/google_calendars/notification?organization=test-name"
        )
      expect(result[:organization]).to eq(organization)
    end
  end
end
