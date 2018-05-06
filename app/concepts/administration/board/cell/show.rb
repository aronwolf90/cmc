# frozen_string_literal: true

module Administration
  module Board
    module Cell
      class Show < Trailblazer::Cell
        include ActionView::RecordIdentifier
        include ActionView::Helpers::FormOptionsHelper
        include SimpleForm::ActionViewExtensions::FormHelper
      end
    end
  end
end
