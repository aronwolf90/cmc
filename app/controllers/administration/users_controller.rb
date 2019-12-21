# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    side_menu "administration/users", only: %i[index new create]
    side_menu "administration/specific_user", only: %i[show update]
    namespace Administration::Users

    public :index

    def new
      super(render: :create)
    end

    def show
      edit(render: :update)
    end

    def update
      super(render: :update) do |model|
        administration_user_path(model)
      end
    end
  end
end
