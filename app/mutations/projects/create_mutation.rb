# frozen_string_literal: true

module Projects
  class CreateMutation < StandardCreateMutation
    def call
      ActiveRecord::Base.transaction do
        super.tap do
          User.where(selected_project_id: nil)
              .update_all(selected_project_id: model.id)
          mutation(BoardList, :create).call(
            model: BoardList.new,
            kind: "open",
            name: "Open",
            ordinal_number: 0,
            project_id: model.id
          )
          mutation(BoardList, :create).call(
            model: BoardList.new,
            kind: "other",
            name: "In progress",
            ordinal_number: 1,
            project_id: model.id
          )
          mutation(BoardList, :create).call(
            model: BoardList.new,
            kind: "closed",
            name: "Closed",
            ordinal_number: 2,
            project_id: model.id
          )
        end
      end
    end
  end
end
