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

  def add_btn(model_class, path: nil)
    path ||= [:new, :administration, model_class.name.underscore]
    return unless policy(model_class).new?
    standard_btn "add #{model_class.model_name.human}", path
  end

  def edit_btn(model, path: nil)
    path ||= [:edit, :administration, model]
    return unless policy(model).edit?
    standard_btn fa_icon(:edit), [:edit, :administration, model]
  end
end
