# frozen_string_literal: true

module Administration
  module Projects
    class RecordsController < BaseProjectsController
      namespace ProjectRecords

      def index
        run ProjectRecords::IndexOperation

        respond_to do |format|
          format.html do
            render cell(
              ProjectRecords::Cell::Index,
              result["model"],
              this_month_spended_time: result["this_month_spended_time"],
              project: result[:project]
            )
          end

          format.csv do
            send_data ProjectRecordsCsvExporter.call(result[:records])
          end
        end
      end
    end
  end
end
