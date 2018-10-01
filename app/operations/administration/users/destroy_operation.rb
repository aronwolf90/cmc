# frozen_string_literal: true

module Administration
  module Users
    class DestroyOperation < AdministrationOperation
      step Model(User, :find)
      step Policy::Pundit(UserPolicy, :destroy?)
      step DestroyStep
    end
  end
end
