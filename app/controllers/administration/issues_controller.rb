# frozen_string_literal: true

module Administration
  class IssuesController < AdministrationController
    side_menu :administration

    def show
      render cell(Issues::Cell::Show, ::Issue.find(params[:id]))
    end

    def new
      run Issues::CreateOperation::Present
      render cell(Issues::Cell::Form, @form)
    end

    def create
      run Issues::CreateOperation do
        flash[:notice] = "issue has been created"
        return redirect_to administration_board_path
      end

      render cell(Issues::Cell::Form, @form)
    end
  end
end
