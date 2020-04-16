# frozen_string_literal: true

module Api
  module V1
    class RecordSerializer < ApplicationSerializer
      set_type :records

      attributes :start_time, :end_time

      belongs_to :user, serializer: UserSerializer,
        record_type: :users
      belongs_to :issue, serializer: IssueSerializer,
        record_type: :issues

      link(:self) { api_v1_record_path(object) }
    end
  end
end
