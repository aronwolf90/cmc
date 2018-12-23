# frozen_string_literal: true

class AdministrationController < MenuController
  include MvcStandardActionsConcern
  layout "administration"

  before_action :authenticate_user!
  around_action :set_time_zone

private

  def set_time_zone
    old_time_zone = Time.zone
    Organization.current.try do |organization|
      Time.zone = organization.time_zone
    end
    yield
  ensure
    Time.zone = old_time_zone
  end
end
