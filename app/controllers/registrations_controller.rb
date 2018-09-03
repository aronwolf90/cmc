# frozen_string_literal: true

class RegistrationsController < ApplicationController
  include MvcStandardActionsConcern
  layout "devise"
  namespace Registrations

  def new
    super
  end

  def create
    super do |model|
      helpers.organization_sign_in_url(model.organization)
    end
  end
end
