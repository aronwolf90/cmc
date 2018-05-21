# frozen_string_literal: true

module Administration
  class DashboardsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration
    namespace Dashboard

    def show
      super
    end
  end
end
