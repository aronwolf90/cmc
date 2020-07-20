# frozen_string_literal: true

class GoogleCalendersController < ApplicationController
  skip_before_action :verify_authenticity_token

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
    logger.info "Headers: #{request.headers.env.reject { |key| key.to_s.include?('.') }}"
    logger.info "Body: #{request.body.read}"

    organization = Organization.find_by(name: params[:organization])

    GoogleCalenders::ImportEventJob.perform_later(
      organization,
      google_calender_event_id: request.headers["X-Goog-Resource-ID"]
    )

    head :ok
  end
end
