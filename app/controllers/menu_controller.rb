# frozen_string_literal: true

class MenuController < ApplicationController
  include MvcStandardActionsConcern

  def self.side_menu(side_menu, **args)
    before_action(
      -> { @side_menu_path = "#{side_menu}/shared/side_menu" },
      **args
    )
  end
end
