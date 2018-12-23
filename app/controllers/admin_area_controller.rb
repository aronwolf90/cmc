# frozen_string_literal: true

class AdminAreaController < MenuController
  include MvcStandardActionsConcern
  layout "admin_area"
  http_basic_authenticate_with(
    name: "admin",
    password: Settings.admin_password
  )
end
