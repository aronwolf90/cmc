# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration

    def show
      render cell(Issues::Cell::Show, ::Issue.find(params[:id]))
    end

    def new
      super(Issues::CreateOperation::Present, Issues::Cell::Form)
    end

    def create
      super(Issues::CreateOperation, Issues::Cell::Form, administration_board_path)
    end
  end
end
