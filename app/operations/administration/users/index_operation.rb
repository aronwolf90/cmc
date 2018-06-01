# frozen_string_literal: true

module Administration
  module Users
    class IndexOperation < AdministrationOperation
      step :model

      def model(options, *)
        options["model"] = User.all
      end
    end
  end
end
