# frozen_string_literal: true

class RegistrationsController < ApplicationController
  include MvcStandardActionsConcern
  layout "devise"
  namespace Registrations

  public :new

  def create
    recaptcha = !Settings.recaptcha_enabled ||
      verify_recaptcha ||
      Settings.recaptcha_ignore_key == params[:recaptcha_ignore_key]
    result = Registrations::CreateOperation.call(
      params: params,
      recaptcha: recaptcha,
      current_user: current_user
    )

    @model = result[:model]
    @form = result["contract.default"]
    session[:organization_display_name] = params.dig(:data, :name)

    if result.success?
      redirect_to helpers.organization_sign_in_url(@model.organization)
    else
      render :form
    end
  end
end
