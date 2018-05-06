# frozen_string_literal: true

module Administration
  class BoardsController < AdministrationController
    side_menu :administration

    def show
      render cell(Board::Cell::Show)
    end
  end
end
