# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu "administration/users"
    namespace Users

    def edit
      super
    end

    def update
      super do |model|
        [:edit, :administration, model]
      end
    end
  end
end
