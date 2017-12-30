module Administration
  class BoardsController < AdministrationController
    side_menu :administration

    def show
      run Board::Show

      render cell(Board::Cell::Show)
    end

    def update
      debugger
      run Board::Update
    end
  end
end
