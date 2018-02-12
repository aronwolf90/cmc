# frozen_string_literal: true

module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :firstname

      has_many :issues, serializer: IssueSerializer
      has_one :current_record
    end
  end
end
