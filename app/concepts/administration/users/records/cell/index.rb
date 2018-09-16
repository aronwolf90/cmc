# frozen_string_literal: true

module Administration
  module Users
    module Records
      module Cell
        class Index < Projects::Records::Cell::Index
          def csv_btn
            standard_btn fa_icon(:"file-excel-o"),
              administration_user_records_path(
                options[:parent], format: :csv
              )
          end
        end
      end
    end
  end
end
