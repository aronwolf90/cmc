# frozen_string_literal: true

module Administration::Users
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def cancel_path
        edit_administration_user_path(model)
      end
    end
  end
end
