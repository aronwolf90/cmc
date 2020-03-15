# frozen_string_literal: true

module Projects
  class UpdateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        if attributes[:project_status_id].present?
          attributes[:project_board_list_id] =
            ProjectStatus.find(attributes[:project_status_id])
            .project_board_lists.first&.id
        end
        attributes.delete(:project_status_id)
        super
      end
    end
  end
end
