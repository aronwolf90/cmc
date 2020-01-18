# frozen_string_literal: true

module Api::V1
  module Users
    class UpdateDeserializer < ApiDeserializer
      attribute :firstname
      attribute :lastname
      attribute :email
      belongs_to :selected_project
    end
  end
end
