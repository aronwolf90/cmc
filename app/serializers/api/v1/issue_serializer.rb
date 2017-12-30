module Api
  module V1
    class IssueSerializer < ActiveModel::Serializer
      attributes :title, :description
    end
  end
end
