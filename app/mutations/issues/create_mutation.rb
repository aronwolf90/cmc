# frozen_string_literal: true

module Issues
  class CreateMutation < StandardUpdateMutation
    attr_reader :project_id, :indicated_board_list

    def call
      @project_id = attributes.delete(:project_id) || user.selected_project_id
      @indicated_board_list = attributes[:board_list_id].present? ?
      BoardList.find(attributes[:board_list_id]) : nil

      model.assign_attributes(attributes)

      model.board_list_id = board_list_id
      model.global_board_list_id = global_board_list_id
      model.ordinal_number = 0
      model.global_ordinal_number = 0
      ordered_issues = model.board_list&.issues
      global_ordered_issues = model.global_board_list&.issues

      ActiveRecord::Base.transaction do
        model.save!

        SortMutation.call(
          ordered_issues,
          sort_key: :ordinal_number,
          model: model
        )
        SortMutation.call(
          global_ordered_issues,
          sort_key: :global_ordinal_number,
          model: model
        )
      end
    end

  private
    def global_board_list_id
      if indicated_board_list.nil?
        BoardList.find_by(project_id: nil, kind: :open).id
      elsif global_board?
        indicated_board_list&.id
      else
        (BoardList.find_by(project_id: nil, kind: indicated_board_list.kind) ||
         BoardList.find_by(project_id: nil, kind: :open))&.id
      end
    end

    def board_list_id
      return if indicated_board_list.present? && global_board? && project_id.nil?

      if indicated_board_list.nil?
        BoardList.find_by(project_id: project_id, kind: :open).id
      elsif global_board?
        (BoardList.find_by(project_id: project_id, kind: indicated_board_list.kind) ||
         BoardList.find_by(project_id: project_id, kind: :open))&.id
      else
        indicated_board_list.id
      end
    end

    def global_board?
      indicated_board_list&.project_id.nil?
    end
  end
end
