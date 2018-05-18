# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu "administration/projects"

    def index
      super(Projects::IndexOperation, Projects::Cell::Index)
    end

    def new
      super(Projects::CreateOperation::Present, Projects::Cell::Form)
    end

    def create
      super(Projects::CreateOperation, Projects::Cell::Form, %i[administration projects])
    end

    def edit
      super(Projects::UpdateOperation::Present, Projects::Cell::Form)
    end

    def update
      super(Projects::UpdateOperation, Projects::Cell::Form, %i[administration projects])
    end
  end
end
