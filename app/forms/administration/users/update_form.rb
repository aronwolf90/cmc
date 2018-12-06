# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  module Users
    class UpdateForm < ApplicationForm
      feature Coercion
      model User

      property :firstname
      property :lastname
      property :email
      property :avatar
      property :avatar_cache
      property :telephone_number

      validates :firstname, presence: true
      validates :lastname, presence: true
      validates :email, presence: true
    end
  end
end
