# frozen_string_literal: true

module Administration
  class DashboardsController < AdministrationController
    side_menu :administration
    namespace Administration::Dashboard

    public :show
  end
end
