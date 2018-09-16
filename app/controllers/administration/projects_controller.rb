# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    side_menu "administration/projects"
    namespace Projects

    public :index, :new, :edit

    def create
      super { %i[administration projects] }
    end

    def update
      super { %i[administration projects] }
    end

    def destroy
      super %i[administration projects]
    end
  end
end
