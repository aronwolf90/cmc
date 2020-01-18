# frozen_string_literal: true

module Api::V1
  module Users
    class CreateDeserializer < ApiDeserializer
      attribute :firstname
      attribute :lastname
      attribute :type
      attribute :email
      belongs_to :selected_project
    end
  end
end
