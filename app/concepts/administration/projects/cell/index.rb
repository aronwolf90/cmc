# frozen_string_literal: true

module Administration
  module Projects::Cell
    class Index < ApplicationCell
    private

      def new_btn
        return unless policy(Project).create?
        link_to "New project", new_administration_project_path,
          class: "btn btn-success btn-block"
      end

      def edit_btn(project)
        return unless policy(project).update?
        link_to fa_icon(:edit), [:edit, :administration, project],
          class: "btn btn-sm btn-secondary"
      end
    end
  end
end
