# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    if Apartment::Tenant.current == "public" && Settings.multi_tenant
      redirect_to request.protocol + [
        params[:organization],
        "#{request.host_with_port}/users/sign_in"
      ].join(".")
    else
      super
    end
  end
end
