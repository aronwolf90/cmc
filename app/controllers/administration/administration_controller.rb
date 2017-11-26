module Administration
  class AdministrationController < ActionController::Base
    layout 'administration'

    before_action :authenticate_user!
    before_action :set_side_menu

    protected

    def set_side_menu
      @side_menu = 'administration/shared/side_menu'
    end
  end
end
