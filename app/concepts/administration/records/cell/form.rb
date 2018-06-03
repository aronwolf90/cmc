# frozen_string_literal: true

module Administration
  module Records::Cell
    class Form < ApplicationCell
    private

      def issues_collection
        ::Issue.all.map do |issue|
          [issue, issue.id]
        end
      end

      def cancell_btn
        link_to "Cancel", administration_records_path,
          class: "btn btn-secondary pull-right"
      end
    end
  end
end
