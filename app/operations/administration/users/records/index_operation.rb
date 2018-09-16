# frozen_string_literal: true

module Administration::Users
  module Records
    class IndexOperation < BaseOperation
      success ParentStep.new(model: User, key: :user_id)
      success MvcIndexParentModelStep.new(relation: :record_days, per: 5)
      step Policy::Pundit(RecordPolicy, :index?)
      success IndexMonthTimeStep
    end
  end
end
