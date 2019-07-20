# frozen_string_literal: true

module Administration
  module Projects
    class IndexOperation < AdministrationOperation
      step :model
      step Policy::Pundit(ProjectPolicy, :index?)

      def model(options, current_user:, **)
        options["model"] =
          ProjectPolicy::Scope.call(current_user, Project)
      end
    end
  end
end
