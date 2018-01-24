module Administration::BoardList
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

      private

      def cancel_path
        administration_board_path
      end
    end
  end
end
