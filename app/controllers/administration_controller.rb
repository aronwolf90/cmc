# frozen_string_literal: true

class AdministrationController < ApplicationController
  include MvcStandardActionsConcern
  layout "administration"

  before_action :authenticate_user!
  before_action :set_side_menu_path

  def self.side_menu(menu)
    define_method :side_menu do
      menu
    end
    private :side_menu
  end

private

  def set_side_menu_path
    @side_menu_path ||= "#{side_menu}/shared/side_menu"
  end
end
