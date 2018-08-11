# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    side_menu :administration
    namespace Issues

    def show
      super
    end

    def new
      super
    end

    def create
      super { administration_board_path }
    end
  end
end
