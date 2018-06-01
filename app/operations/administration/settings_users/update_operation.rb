# frozen_string_literal: true

module Administration
  module SettingsUsers
    class UpdateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(User, :find)
        step Contract::Build(constant: SettingsUserForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
