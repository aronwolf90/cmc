module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :firstname

      has_many :issues
    end
  end
end
