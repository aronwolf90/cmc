# frozen_string_literal: true

module Users
  class CreateMutation < StandardCreateMutation
    def call
      ActiveRecord::Base.transaction do
        model.selected_project = Project.first
        super
      end
    end
  end
end
