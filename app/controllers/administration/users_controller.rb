# frozen_string_literal: true

module Administration
  class UsersController < AdministrationController
    side_menu "administration/users"

    def edit
      run Administration::Users::UpdateOperation::Present
      render cell(Users::Cell::Form, @form)
    end

    def update
      run Administration::Users::UpdateOperation do |result|
        flash[:notice] = "user has been update"
        return redirect_to [:edit, :administration, result[:model]]
      end

      render cell(Users::Cell::Form, @form)
    end
  end
end
