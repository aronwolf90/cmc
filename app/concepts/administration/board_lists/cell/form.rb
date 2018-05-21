# frozen_string_literal: true

module Administration::BoardLists
  module Cell
    class Form < Trailblazer::Cell
      include ActionView::RecordIdentifier
      include ActionView::Helpers::FormOptionsHelper
      include SimpleForm::ActionViewExtensions::FormHelper

      private

        def cancel_path
          administration_board_path
        end

        def project_collection
          Project.all.map do |project|
            [project.name, project.id]
          end
        end
    end
  end
end
