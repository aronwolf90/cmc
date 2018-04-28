# frozen_string_literal: true

module Administration
  class RecordsController < AdministrationController
    side_menu :administration

    def index
      run Records::IndexOperation
      render cell(
        Records::Cell::Index,
        result["model"],
        records: result["records"],
        records_for_month: result["records_for_month"]
      )
    end

    def new
      run Records::CreateOperation::Present
      render cell(Records::Cell::Form, @form)
    end

    def create
      run Records::CreateOperation do
        flash[:notice] = "record has been created"
        return redirect_to [:administration, :records]
      end

      render cell(Records::Cell::Form, @form)
    end

    def edit
      run Records::UpdateOperation::Present
      render cell(Records::Cell::Form, @form)
    end

    def update
      run Records::UpdateOperation do
        flash[:notice] = "record has been update"
        return redirect_to [:administration, :records]
      end

      render cell(Records::Cell::Form, @form)
    end

    def destroy
      run Records::DestroyOperation
      flash[:notice] = "record has been destroyed"
      redirect_to %i[administration records]
    end
  end
end
