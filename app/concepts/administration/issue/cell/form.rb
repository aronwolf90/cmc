# frozen_string_literal: true

module Administration::Issue
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def board_lists
        @board_lists || BoardList.all
      end

      def cancel_path
        administration_board_path
      end
    end
  end
end
