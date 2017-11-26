module Administration
  class DashboardController < AdministrationController
    def index
      render inline: 'hi', layout: true
    end
  end
end
