# frozen_string_literal: true

module Administration
  module Users
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(User, :new)
        step Contract::Build(constant: UserForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
