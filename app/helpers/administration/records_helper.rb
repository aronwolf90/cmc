# frozen_string_literal: true

module Administration
  module RecordsHelper
    include AdministrationHelper

    def new_record_btn
      new_btn(Record)
    end

    def csv_records_btn
      csv_btn(Record)
    end

    def edit_record_btn(record)
      edit_btn(record)
    end
  end
end
