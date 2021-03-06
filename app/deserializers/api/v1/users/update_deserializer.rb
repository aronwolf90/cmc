# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateDeserializer < ApiDeserializer
      attribute :firstname
      attribute :lastname
      attribute :email
      attribute :telephone_number
      belongs_to :selected_project
      belongs_to :user_avatar
    end
  end
end
