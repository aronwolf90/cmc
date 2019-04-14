# frozen_string_literal: true

module Administration
  class BoardListsController < AdministrationController
    side_menu :administration
    namespace Administration::BoardLists

    public :new, :create, :edit, :update, :destroy

    def index; end
  end
end
