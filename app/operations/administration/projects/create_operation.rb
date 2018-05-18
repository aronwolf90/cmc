# frozen_string_literal: true

module Administration
  module Projects
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::Project, :new)
        step Contract::Build(constant: ProjectForm)
      end

      include Concerns::StandartTrailblazerSteps
    end
  end
end
