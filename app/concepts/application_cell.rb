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
    options[:current_user]
  end

  def add_btn(model_class:, name:, path:)
    return unless policy(model_class).new?
    standard_btn "add #{name}", path
  end
end
