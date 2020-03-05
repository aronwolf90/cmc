# frozen_string_literal: true

module Administration
  class BoardListsController < AdministrationController
    side_menu :administration
    namespace Administration::BoardLists

    public :new, :edit, :update, :destroy

    def create
      super { "/administration/board_lists" }
    end

    def update
      super { "/administration/board_lists" }
    end

    def destroy
      super("/administration/board_lists")
    end
  end
end
