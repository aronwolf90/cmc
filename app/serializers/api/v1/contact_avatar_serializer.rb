# frozen_string_literal: true

module Api
  module V1
    class ContactAvatarSerializer < ApplicationSerializer
      attribute :file

      def file
        object.file.as_json
      end
    end
  end
end
