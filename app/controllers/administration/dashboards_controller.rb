# frozen_string_literal: true

module Administration
  class DashboardsController < AdministrationController
    side_menu :administration
    namespace Dashboard

    def show
      super
    end
  end
end
