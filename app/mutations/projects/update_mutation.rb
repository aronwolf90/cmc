# frozen_string_literal: true

module Projects
  class UpdateMutation < StandardUpdateMutation
    def call
      ActiveRecord::Base.transaction do
        if attributes[:project_status_id].present?
          attributes[:project_board_list_id] =
            ProjectStatus.find(attributes[:project_status_id])
            .project_board_lists.first&.id
        elsif attributes.key?(:project_status_id)
          attributes[:project_board_list_id] = nil
        end
        attributes.delete(:project_status_id)

        super

        SortMutation.call(
          model&.project_board_list&.projects,
          sort_key: :ordinal_number,
          model: model
        )
      end
    end

  private
    def ordinal_number
      attributes[:ordinal_number]
    end

    def projects_to_order
      project_status
        .projects
        .where.not(id: model.id)
        .order(:ordinal_number, :created_at, :id)
    end

    def projects_after_model
      project_status
        .projects
        .where("ordinal_number >= ?", ordinal_number)
        .where.not(id: model.id)
        .order(:ordinal_number, :created_at, :id)
    end

    def project_status
      model.project_status
    end
  end
end
