# frozen_string_literal: true

module Administration
  module Users
    class UpdateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(User, :find)
        step Contract::Build(constant: UserForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
