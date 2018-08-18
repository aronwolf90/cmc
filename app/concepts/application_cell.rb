# frozen_string_literal: true

class ApplicationCell < Trailblazer::Cell
  include ActionView::RecordIdentifier
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::TranslationHelper
  include FontAwesome::Rails::IconHelper
  include Kaminari::Cells
  include SimpleForm::ActionViewExtensions::FormHelper
  include ApplicationHelper
  include Pundit

  def current_user
    controller.current_user
  end
end
