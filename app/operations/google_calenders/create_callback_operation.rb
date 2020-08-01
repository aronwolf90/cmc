# frozen_string_literal: true

module GoogleCalenders
  class CreateCallbackOperation < ApplicationOperation
    include ApplicationHelper

    success :get_authorization
    success :create_google_calender
    success :create_web_hook
    success :mutate
    success :export_events

  private
    def get_authorization(ctx, code:, organization:, **)
      ctx[:google_authorization_data] = GoogleCalenderClient.get_access_token(code: code)
      if ctx[:google_authorization_data].refresh_token.nil?
        refresh_token = organization.google_calender_authorization_data.refresh_token
        ctx[:google_authorization_data] =
          ctx[:google_authorization_data].new(refresh_token: refresh_token)
      end
    end

    def create_google_calender(ctx, google_authorization_data:, organization:, **)
      ctx[:calender] = GoogleCalenderClient.create_calender(
        name: organization.name,
        google_authorization_data: google_authorization_data
      )
    end

    def create_web_hook(ctx, calender:, google_authorization_data:, organization:, **)
      return unless Settings.google_calender.web_hook

      GoogleCalenderClient.watch(
        google_calender_id: calender.id,
        google_authorization_data: google_authorization_data,
        url: google_calender_notification_url(organization.name)
      )
    end

    def mutate(_, organization:, calender:, google_authorization_data:, **)
      GoogleCalenders::CreateCallbackMutation.(
        organization: organization,
        calender: calender,
        google_calender_authorization_data: google_authorization_data
      )
    end

    def export_events(ctx, organization:, **)
      GoogleCalenders::ExportEventsJob.perform_later(organization)
    end
  end
end
