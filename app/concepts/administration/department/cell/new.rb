# frozen_string_literal: true

module Administration::Project
  module Cell
    class Create < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper
    end
  end
end
