module Api
  module V1
    class BoardListSerializer < ActiveModel::Serializer
      attributes :name, :ordinal_number

      has_many :issues
    end
  end
end
