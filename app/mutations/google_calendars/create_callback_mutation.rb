# frozen_string_literal: true

module GoogleCalendars
  class CreateCallbackMutation < ApplicationMutation
    attr_reader :organization, :calendar, :google_calendar_authorization_data

    def initialize(organization:, calendar:, google_calendar_authorization_data:)
      @organization = organization
      @calendar = calendar
      @google_calendar_authorization_data = google_calendar_authorization_data
    end

    def call
      organization.update!(
        google_calendar_id: calendar.id,
        google_calendar_authorization_data: google_calendar_authorization_data
      )
    end
  end
end
