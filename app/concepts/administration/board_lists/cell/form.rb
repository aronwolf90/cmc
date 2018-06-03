# frozen_string_literal: true

module Administration
  module BoardLists::Cell
    class Form < ApplicationCell
    private

      def cancel_btn
        link_to "Cancel", administration_board_path,
          class: "btn btn-secondary pull-right"
      end

      def project_collection
        Project.all.map do |project|
          [project.name, project.id]
        end
      end
    end
  end
end
