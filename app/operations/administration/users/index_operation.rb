# frozen_string_literal: true

module Administration::Users
  class IndexOperation < BaseOperation
    step :model
    step Policy::Pundit(UserPolicy, :index?)

    def model(options, current_user:, **)
      options["model"] =
        UserPolicy::Scope.(current_user, User)
    end
  end
end
