# frozen_string_literal: true

module Administration
  module Projects
    module Records
      module Cell
        class Index < Administration::Records::Cell::Index
          def add_btn; end

          def edit_btn(_); end

          def csv_btn
            standard_btn fa_icon(:"file-excel-o"),
              administration_project_records_path(
                options[:parent], format: :csv
              )
          end
        end
      end
    end
  end
end