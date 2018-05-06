# frozen_string_literal: true

module Administration
  module Projects
    class IndexOperation < AdministrationOperation
      step :model!

      def model!(options, *)
        options["model"] = ::Project.all
      end
    end
  end
end
