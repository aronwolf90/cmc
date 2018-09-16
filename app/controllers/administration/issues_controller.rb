# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    side_menu :administration
    namespace Issues

    public :show, :new

    def create
      super { administration_board_path }
    end
  end
end
