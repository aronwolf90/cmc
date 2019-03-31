# frozen_string_literal: true

module Administration
  module Projects
    module RecordsHelper
      include AdministrationHelper

      def new_record_btn; end

      def csv_records_btn
        csv_btn([@parent, Record])
      end

      def edit_record_btn(record); end
    end
  end
end
