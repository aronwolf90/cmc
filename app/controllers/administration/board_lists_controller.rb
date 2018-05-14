# frozen_string_literal: true

module Administration
  class BoardListsController < AdministrationController
    side_menu :administration

    def new
      run ::Administration::BoardLists::CreateOperation::Present
      render cell(BoardList::Cell::Form, @form)
    end

    def create
      run ::Administration::BoardLists::CreateOperation do |result|
        flash[:notice] = "board list has been created"
        return redirect_to administration_board_path
      end

      render cell(BoardList::Cell::Form, @form)
    end
  end
end
