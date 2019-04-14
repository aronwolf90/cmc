# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    side_menu "administration/users", only: %i[index new create]
    side_menu "administration/specific_user", only: %i[edit update]
    namespace Administration::Users

    public :index

    def new
      super(render: :create)
    end

    def edit
      super(render: :update)
    end

    def create
      super(render: :create)
    end

    def update
      super(render: :update) do |model|
        edit_administration_user_path(model)
      end
    end
  end
end
