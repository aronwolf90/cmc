# frozen_string_literal: true

module Administration::Projects
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def cancel_btn
        link_to "Cancel", administration_projects_path,
          class: "btn btn-secondary pull-right"
      end
    end
  end
end
