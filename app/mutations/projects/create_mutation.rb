# frozen_string_literal: true

module Projects
  class CreateMutation < StandardCreateMutation
    def call
      ActiveRecord::Base.transaction do
        super.tap do
          User.where(selected_project_id: nil)
              .update_all(selected_project_id: model.id)
        end
      end
    end
  end
end
