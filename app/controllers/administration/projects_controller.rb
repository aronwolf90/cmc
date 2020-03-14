# frozen_string_literal: true

module Administration
  class ProjectsController < AdministrationController
    side_menu "administration/projects", except: :show
    side_menu "administration/specific_project", only: :show
    before_action :set_project, only: :show
    namespace Administration::Projects

    public :index, :new, :edit, :create, :update, :destroy

    def show; end

    def update
      super { "/administration/projects" }
    end

    def destroy
      super("/administration/projects")
    end

  private
    def set_project
      @project = ::Project.find(params[:id])
    end
  end
end
