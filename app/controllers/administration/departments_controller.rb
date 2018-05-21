# frozen_string_literal: true

module Administration
  class DepartmentsController < Administration::AdministrationController
    include Concerns::Administration::StandardActions
    side_menu "administration/departments"
    namespace Departments

    def index
      super
    end
  end
end
