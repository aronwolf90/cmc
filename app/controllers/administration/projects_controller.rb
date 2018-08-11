# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    side_menu "administration/projects"
    namespace Projects

    def index
      super
    end

    def new
      super
    end

    def create
      super { %i[administration projects] }
    end

    def edit
      super
    end

    def update
      super { %i[administration projects] }
    end

    def destroy
      super %i[administration projects]
    end
  end
end
