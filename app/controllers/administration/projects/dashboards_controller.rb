# frozen_string_literal: true

module Administration
  module Projects
    class DashboardsController < BaseProjectsController
      def show
        render cell(Projects::Cell::Show, @project)
      end
    end
  end
end
