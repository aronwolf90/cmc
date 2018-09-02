# frozen_string_literal: true

class AdministrationController < ApplicationController
  include MvcStandardActionsConcern
  layout "administration"

  before_action :authenticate_user!
  before_action :set_side_menu_path
  around_action :set_time_zone

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
