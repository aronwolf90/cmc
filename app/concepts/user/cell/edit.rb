module User::Cell
  class Edit < Trailblazer::Cell
    include ActionView::RecordIdentifier
    include ActionView::Helpers::FormOptionsHelper
    include SimpleForm::ActionViewExtensions::FormHelper

    private

    def cancel_path
      edit_administration_user_settings_user_path(model)
    end
  end
end
