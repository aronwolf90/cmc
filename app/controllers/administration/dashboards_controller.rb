# frozen_string_literal: true

module Administration
  class DashboardsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration

    def show
      super(Dashboard::ShowOperation, Dashboard::Cell::Show)
    end
  end
end
