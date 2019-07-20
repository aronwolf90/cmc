# frozen_string_literal: true

module Api::V1
  class UserIssuesController < ApiController
    include StandartActions
    model_class UserIssue

    public :index, :show

    private
      def model
        @model ||=
          model_class
          .find_or_initialize_by(user_id: id[0], issue_id: id[1])
      end
  end
end
