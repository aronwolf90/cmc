# frozen_string_literal: true

module Administration::Users
  module Records
    class IndexCsvOperation < BaseOperation
      success ParentStep.new(model: User, key: :user_id)
      success IndexParentModelStep.new(relation: :records)
      step Policy::Pundit(RecordPolicy, :index?)
    end
  end
end
