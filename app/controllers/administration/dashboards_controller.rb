# frozen_string_literal: true

module Administration
  class DashboardsController < AdministrationController
    side_menu :administration

    def show
      run Dashboard::Show
      render cell(Dashboard::Cell::Show, result["model"])
    end
  end
end
