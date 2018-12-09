# frozen_string_literal: true

module Administration
  module Projects
    class DestroyOperation < AdministrationOperation
      step Model(Project, :find)
      step Policy::Pundit(ProjectPolicy, :destroy?)
      step MvcDestroyMutationStep
    end
  end
end
