# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    side_menu "administration/projects"
    namespace Administration::Projects

    public :index, :new, :edit, :create, :update, :destroy
  end
end
