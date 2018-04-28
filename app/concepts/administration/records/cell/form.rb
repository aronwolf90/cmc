# frozen_string_literal: true

module Administration::Records
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def issues_collection
        Issue.all.map do |issue|
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
