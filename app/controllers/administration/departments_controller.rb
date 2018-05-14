# frozen_string_literal: true

module Administration
  class DepartmentsController < Administration::AdministrationController
    side_menu "administration/departments"

    def index
      run Department::Index
      render cell(Department::Cell::Index, result["model"])
    end
  end
end
