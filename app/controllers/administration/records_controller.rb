# frozen_string_literal: true

module Administration
  class RecordsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration

    def index
      run Records::IndexOperation
      render cell(
        Records::Cell::Index,
        result["model"],
        this_mounth_spended_time: result["this_mounth_spended_time"]
      )
    end

    def new
      super(Records::CreateOperation::Present, Records::Cell::Form)
    end

    def create
      super(Records::CreateOperation, Records::Cell::Form, [:administration, :records])
    end

    def edit
      super(Records::UpdateOperation::Present, Records::Cell::Form)
    end

    def update
      super(Records::UpdateOperation, Records::Cell::Form, [:administration, :records])
    end

    def destroy
      super(Records::DestroyOperation, %i[administration records])
    end
  end
end
