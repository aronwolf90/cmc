module Administration
  class IssuesController < AdministrationController
    side_menu :administration

    def show
      render cell(Issue::Cell::Show, issue)
    end

    def new
      issue_form = Issue::NewForm.new(board_list: board_list)

      render cell(Issue::Cell::Form, issue_form)
    end

    def create
      issue_form = Issue::NewForm.new(
        board_list: board_list, params: issue_form_params
      )

      if issue_form.save
        render cell(Board::Cell::Show, issue_form)
      else
        render cell(Issue::Cell::Form, issue_form)
      end
    end

    def edit
      edit_form = Issue::EditForm.new(
        issue: issue, board_list: board_list
      )

      render cell(Issue::Cell::Form, edit_form)
    end

    def update
      edit_form = Issue::EditForm.new(
        issue: issue, board_list: board_list, params: issue_form_params
      )

      if edit_form.update
        redirect_to administration_board_path
      else
        render cell(Issue::Cell::Form, edit_form)
      end
    end

    private

    def issue
      @issue ||= ::Issue.find(params[:id])
    end

    def board_list
      @board_list ||= ::BoardList.find(params[:board_list_id])
    end

    def issue_form_params
      params.require(:issue).permit(:title, :description, :board_list_id)
    end
  end
end
