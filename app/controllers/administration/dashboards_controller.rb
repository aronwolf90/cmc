module Administration
  class DashboardsController < AdministrationController
    side_menu :administration

    def show
      run Dashboard::Show

      render cell(Dashboard::Cell::Show, @form)
    end
  end
end
