# frozen_string_literal: true

module Administration
  class DepartmentsController < Administration::AdministrationController
    include Concerns::Administration::StandardActions
    side_menu "administration/departments"

    def index
      super(Department::Index, Department::Cell::Index)
    end
  end
end
