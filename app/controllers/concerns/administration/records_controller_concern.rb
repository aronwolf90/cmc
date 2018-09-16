# frozen_string_literal: true

module Administration
  module RecordsControllerConcern
    include CsvIndexConcern

    def index
      respond_to do |format|
        format.html do
          super(cell_options: %i[parent this_month_spended_time])
        end

        format.csv { csv_index }
      end
    end
  end
end
