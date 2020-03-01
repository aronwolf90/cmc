# frozen_string_literal: true

module Issues
  class CreateMutation < StandardUpdateMutation
    attr_reader :project_id, :indicated_board_list

    def call
      @project_id = attributes.delete(:project_id)
      @indicated_board_list = model.board_list

      ActiveRecord::Base.transaction do
        model.assign_attributes(attributes)

        model.board_list_id = board_list_id
        model.global_board_list_id = global_board_list_id
        model.ordinal_number = 0

        model.board_list&.issues&.ordered.to_a.each_with_index do |issue, index|
          issue.update!(ordinal_number: (issue.ordinal_number || index) + 1)
        end
        model.global_board_list&.issues&.ordered.to_a.each_with_index do |issue, index|
          issue.update!(global_ordinal_number: (issue.ordinal_number || index) + 1)
        end

        model.save!
      end
    end

  private
    def global_board_list_id
      if global_board?
        indicated_board_list&.id
      else
        (BoardList.find_by(project_id: nil, kind: indicated_board_list.kind) ||
         BoardList.find_by(project_id: nil, kind: :open))&.id
      end
    end

    def board_list_id
      return if global_board? && project_id.nil?

      if global_board?
        (BoardList.find_by(project_id: project_id, kind: indicated_board_list.kind) ||
         BoardList.find_by(project_id: project_id, kind: :open))&.id
      else
        indicated_board_list.id
      end
    end

    def global_board?
      indicated_board_list.project_id.nil?
    end
  end
end
