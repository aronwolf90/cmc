# frozen_string_literal: true

class GoogleCalendersController < ApplicationController
  def create_callback
    if Organization.current.nil?
      organization = Organization.find_by(name: params[:state])
      url = "#{helpers.organization_url(organization)}"
      return redirect_to "#{url}/google_calenders/create_callback?code=#{params[:code]}"
    else
      authenticate_user!
    end

    GoogleCalenders::CreateCallbackOperation.(
      organization: Organization.current,
      code: params[:code]
    )

    redirect_to "/administration/calender"
  end

  def notification
    organization = Organization.current
    return head(:bad_request) if organization.nil?

    GoogleCalenders::ImportEventJob.perform_later(
      organization,
      google_calender_event_id: request.headers["X-Goog-Resource-ID"]
    )

    head :ok
  end
end
