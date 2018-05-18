# frozen_string_literal: true

module Administration
  module Projects
    class UpdateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::Project, :find)
        step Contract::Build(constant: ProjectForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
