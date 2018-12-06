# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  module Users
    class CreateForm < ApplicationForm
      feature Coercion
      model User

      property :firstname
      property :lastname
      property :email
      property :type
      property :password
      property :password_confirmation
      property :project_ids

      validates :firstname, presence: true
      validates :lastname, presence: true
      validates :email, presence: true
      validates :type, presence: true
      validates :password, presence: true
      validates :password_confirmation, presence: true

      validate :same_password

      def same_password
        return if password_confirmation == password

        errors.add(:password_confirmation, "Diferent password")
      end
    end
  end
end
