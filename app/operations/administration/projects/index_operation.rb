# frozen_string_literal: true

module Administration
  module Projects
    class IndexOperation < AdministrationOperation
      step :model

      def model(options, current_user:, **)
        options["model"] =
          ProjectPolicy::Scope.(current_user, Project)
      end
    end
  end
end
