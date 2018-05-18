# frozen_string_literal: true

module Administration
  module Cell
    class Application < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include ActionView::Helpers::TranslationHelper
      include FontAwesome::Rails::IconHelper
      include Kaminari::Cells
      include SimpleForm::ActionViewExtensions::FormHelper
    end
  end
end
