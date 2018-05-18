# frozen_string_literal: true

module Administration
  class BoardListsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration

    def new
      super(
        ::Administration::BoardLists::CreateOperation::Present,
        BoardList::Cell::Form
      )
    end

    def create
      super(
        Administration::BoardLists::CreateOperation,
        BoardList::Cell::Form,
        administration_board_path
      )
    end
  end
end
