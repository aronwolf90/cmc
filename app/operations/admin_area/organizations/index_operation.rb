# frozen_string_literal: true

module AdminArea
  module Organizations
    class IndexOperation < ApplicationOperation
      step :model
      step Policy::Pundit(ProjectPolicy, :index?)

      def model(options, current_user:, **)
        options["model"] = Organization.ordered
      end
    end
  end
end
