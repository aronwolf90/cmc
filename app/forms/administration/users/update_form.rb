# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  module Users
    class UpdateForm < Reform::Form
      feature Coercion
      model User

      property :firstname
      property :lastname
      property :email
      property :avatar
      property :avatar_cache
      property :telephone_number

      validation do
        configure do
          predicates(ReformPredicates)
        end

        required(:firstname).filled
        required(:lastname).filled
        required(:email).filled
      end
    end
  end
end
