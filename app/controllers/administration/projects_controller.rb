# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    side_menu "administration/projects"

    def index
      run Projects::IndexOperation
      render cell(Projects::Cell::Index, result["model"])
    end

    def new
      run Projects::CreateOperation::Present
      render cell(Projects::Cell::Form, result["contract.default"])
    end

    def create
      run Projects::CreateOperation do |result|
        flash[:notice] = "project has been created"
        return redirect_to [:administration, :projects]
      end

      render cell(Projects::Cell::Form, result["contract.default"])
    end

    def edit
      run Projects::UpdateOperation::Present
      render cell(Projects::Cell::Form, result["contract.default"])
    end

    def update
      run Projects::UpdateOperation do |result|
        flash[:notice] = "project has been updated"
        return redirect_to [:administration, :projects]
      end

      render cell(Projects::Cell::Form, result["contract.default"])
    end
  end
end
