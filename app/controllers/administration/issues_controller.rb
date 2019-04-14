# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    side_menu :administration
    namespace Administration::Issues

    public :show, :new

    def create
      super { %i[administration board_lists] }
    end
  end
end
