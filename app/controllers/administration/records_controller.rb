# frozen_string_literal: true

module Administration
  class RecordsController < AdministrationController
    include Concerns::Administration::StandardActions
    side_menu :administration
    namespace Records

    def index
      run Records::IndexOperation
      render cell(
        Records::Cell::Index,
        result["model"],
        this_mounth_spended_time: result["this_mounth_spended_time"]
      )
    end

    def new
      super
    end

    def create
      super { [:administration, :records] }
    end

    def edit
      super
    end

    def update
      super { [:administration, :records] }
    end

    def destroy
      super(%i[administration records])
    end
  end
end
