# frozen_string_literal: true

module Users
  class CreateMutation < StandardCreateMutation
    def call
      ActiveRecord::Base.transaction do
        model.assign_attributes(attributes)
        model.selected_project = Project.first
        model.invite!
      end
    end
  end
end
