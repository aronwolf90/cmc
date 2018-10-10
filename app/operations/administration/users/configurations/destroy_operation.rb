# frozen_string_literal: true

module Administration
  module Users
    module Configurations
      class DestroyOperation < AdministrationOperation
        step ParentAsModelStep.new(model: User, key: :user_id)
        step Policy::Pundit(UserPolicy, :destroy?)
        step DestroyStep
      end
    end
  end
end
