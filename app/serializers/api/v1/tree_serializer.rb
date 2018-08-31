# frozen_string_literal: true

module Api
  module V1
    class TreeSerializer < ActiveModel::Serializer
      def root
        object.root?
      end
    end
  end
end
