# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    if Apartment::Tenant.current == "public" && Settings.multi_tenant
      redirect_to helpers.organization_sign_in_url(organization)
    else
      super
    end
  end

private

  def organization
    @organization ||= Organization.find_by(name: params[:organization])
  end
end
