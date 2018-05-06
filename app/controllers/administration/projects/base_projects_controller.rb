# frozen_string_literal: true

module Administration
  module Projects
    class BaseProjectsController < AdministrationController
      before_action :set_project
      side_menu "administration/specific_project"

    private

      def set_project
        @project = ::Project.find(params[:project_id])
      end
    end
  end
end
