# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    side_menu "administration/users"
    namespace Users

    def index
      super
    end

    def new
      super
    end

    def create
      super { %i[administration users] }
    end
  end
end
