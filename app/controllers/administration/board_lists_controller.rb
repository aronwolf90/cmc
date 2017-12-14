module Administration
  class BoardListsController < AdministrationController
    side_menu :administration

    def index
      run Administration::BoardList::Index

      render json: @model
    end

    def new
      run BoardList::Create::Present

      render cell(BoardList::Cell::Form, @form)
    end

    def create
      run BoardList::Create do
        flash[:notice] = 'Successful created'
        return redirect_to administration_board_path
      end

      render cell(BoardList::Cell::Form, @form)
    end
  end
end
