# frozen_string_literal: true

module Administration
  class RecordsController < AdministrationController
    side_menu :administration
    namespace Records

    def index
      run Records::IndexOperation

      respond_to do |format|
        format.html do
          render cell(
            Records::Cell::Index,
            result["model"],
            this_month_spended_time: result["this_month_spended_time"]
          )
        end

        format.csv do
          send_data RecordsCsvExporter.call(result[:records])
        end
      end
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
