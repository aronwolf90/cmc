module Administration
  class BoardListsController < AdministrationController
    side_menu :administration

    def index
      run Administration::BoardList::Index

      render json: @model
    end

    def new
      board_list_form = Administration::BoardListForm.new

      render cell(BoardList::Cell::Form, board_list_form)
    end

    def create
      board_list_form = Administration::BoardListForm.new(board_list_params)

      if board_list_form.save
        redirect_to administration_board_path
      else
        render cell(BoardList::Cell::Form, board_list_form)
      end
    end

    private

    def board_list
      @board_list ||= BoardList.find
    end

    def board_list_params
      params.require(:board_list).permit(:name)
    end
  end
end
