# frozen_string_literal: true

module Administration
  module Projects
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(::Project, :new)
        step Contract::Build(constant: ProjectForm)
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end
