# frozen_string_literal: true

module Administration
  class BoardListsController < AdministrationController
    side_menu :administration
    namespace Administration::BoardLists

    public :new, :edit

    def create
      super { %i[administration board] }
    end

    def update
      super { %i[administration board] }
    end

    def destroy
      super(%i[administration board])
    end
  end
end
