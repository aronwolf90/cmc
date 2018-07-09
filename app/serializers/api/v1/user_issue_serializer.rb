# frozen_string_literal: true

module Api
  module V1
    class UserIssueSerializer < ActiveModel::Serializer
      attributes :spent_time, :start_time, :id

      belongs_to :user, serializer: UserSerializer
      belongs_to :issue, serializer: IssueSerializer

      def id
        "#{object.user_id},#{object.issue_id}"
      end

      def spent_time
        object.spent_time.to_i
      end
    end
  end
end
