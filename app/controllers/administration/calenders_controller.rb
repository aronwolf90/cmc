# frozen_string_literal: true

module Administration
  class CalendersController < AdministrationController
    side_menu :administration

    def show
      render cell(Calenders::Cell::Show)
    end
  end
end
