# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration
    namespace Issues

    def show
      render cell(Issues::Cell::Show, ::Issue.find(params[:id]))
    end

    def new
      super
    end

    def create
      super { administration_board_path }
    end
  end
end
