# frozen_string_literal: true

module Administration
  module Projects::Cell
    class Form < ApplicationCell
    private

      def cancel_btn
        link_to "Cancel", administration_projects_path,
          class: "btn btn-secondary pull-right"
      end
    end
  end
end
