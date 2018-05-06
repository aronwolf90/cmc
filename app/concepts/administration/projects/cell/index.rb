# frozen_string_literal: true

module Administration::Projects
  module Cell
    class Index < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include ActionView::Helpers::TranslationHelper
      include FontAwesome::Rails::IconHelper
      include Kaminari::Cells
      include SimpleForm::ActionViewExtensions::FormHelper

    private

      def new_btn
        link_to "New project", new_administration_project_path,
          class: "btn btn-success btn-block"
      end

      def edit_btn(project)
        link_to fa_icon(:edit), [:edit, :administration, project],
          class: "btn btn-sm btn-secondary"
      end
    end
  end
end
