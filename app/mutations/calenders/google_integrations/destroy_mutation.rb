# frozen_string_literal: true

module Calenders
  module GoogleIntegrations
    class DestroyMutation < ApplicationMutation
      attr_reader :organization

      def initialize(organization:)
        @organization = organization
      end

      def call
        ActiveRecord::Base.transaction do
          organization.update!(
            google_calender_id: nil,
            google_calender_access_token: nil,
            google_calender_expires_at: nil,
            sync_token: nil
          )
          Event.update_all(google_calender_event_id: nil, updated_at: Time.zone.now)
        end
      end
    end
  end
end
