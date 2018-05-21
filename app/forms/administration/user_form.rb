# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class UserForm < Reform::Form
    feature Coercion
    model User

    property :firstname
    property :lastname
    property :email

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
