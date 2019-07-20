# frozen_string_literal: true

module Projects
  class DestroyMutation < StandardDestroyMutation
    def call
      ActiveRecord::Base.transaction do
        User.where(selected_project: model)
            .update_all(selected_project_id: other_project&.id)
        super
      end
    end

    private
      def other_project
        @other_project ||= Project.all_except(model.id).first
      end
  end
end
