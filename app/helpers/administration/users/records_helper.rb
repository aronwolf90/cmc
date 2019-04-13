# frozen_string_literal: true

module Administration
  module Users
    module RecordsHelper
      include AdministrationHelper

      def new_record_btn; end

      def csv_records_btn
        csv_btn([@parent.becomes(User), Record])
      end

      def edit_record_btn(record); end
    end
  end
end
