# frozen_string_literal: true

module Api
  module V1
    class RecordSerializer < ApplicationSerializer
      attributes :start_time, :end_time, :description

      belongs_to :user, serializer: UserSerializer
      belongs_to :issue, serializer: IssueSerializer

      link(:self) { api_v1_record_path(object) }
    end
  end
end
