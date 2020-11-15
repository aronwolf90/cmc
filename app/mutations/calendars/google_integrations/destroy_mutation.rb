# frozen_string_literal: true

module Calendars
  module GoogleIntegrations
    class DestroyMutation < ApplicationMutation
      attr_reader :organization

      def initialize(organization:)
        @organization = organization
      end

      def call
        ActiveRecord::Base.transaction do
          organization.update!(
            google_calendar_id: nil,
            google_calendar_access_token: nil,
            google_calendar_expires_at: nil,
            sync_token: nil
          )
          Event.update_all(google_calendar_event_id: nil, updated_at: Time.zone.now)
        end
      end
    end
  end
end
