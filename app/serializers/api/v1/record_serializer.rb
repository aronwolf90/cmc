# frozen_string_literal: true

module Api
  module V1
    class RecordSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      attributes :start_time, :end_time

      belongs_to :user, serializer: UserSerializer
      belongs_to :issue, serializer: IssueSerializer

      link(:self) { api_v1_record_path(object) }
    end
  end
end
