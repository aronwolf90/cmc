# frozen_string_literal: true

class AdminAreaController < ApplicationController
  include MvcStandardActionsConcern
  layout "admin_area"
  http_basic_authenticate_with(
    name: "admin",
    password: Settings.admin_password
  )

  def self.side_menu(side_menu, **args)
    before_action(
      -> { @side_menu_path = "#{side_menu}/shared/side_menu" },
      **args
    )
  end
end
