# frozen_string_literal: true

module Administration::Departments
  module Cell
    class Index < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper
    end
  end
end