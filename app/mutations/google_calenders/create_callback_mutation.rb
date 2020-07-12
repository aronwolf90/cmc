# frozen_string_literal: true

module GoogleCalenders
  class CreateCallbackMutation < ApplicationMutation
    attr_reader :organization, :calender, :google_calender_authorization_data

    def initialize(organization:, calender:, google_calender_authorization_data:)
      @organization = organization
      @calender = calender
      @google_calender_authorization_data = google_calender_authorization_data
    end

    def call
      organization.update!(
        google_calender_id: calender.id,
        google_calender_authorization_data: google_calender_authorization_data
      )
    end
  end
end
