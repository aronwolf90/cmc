module Administration
  class IssuesController < AdministrationController
    side_menu :administration

    def new
      run Issue::Create::Present

      render cell(Issue::Cell::Form, @form)
    end

    def create
      run Issue::Create do
        flash[:notice] = 'Successful created'
        return render cell(Board::Cell::Show, @form)
      end

      render cell(Issue::Cell::Form, @form)
    end
  end
end
