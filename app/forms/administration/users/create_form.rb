# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  module Users
    class CreateForm < Reform::Form
      feature Coercion
      model User

      property :firstname
      property :lastname
      property :email
      property :type
      property :password
      property :password_confirmation
      property :project_ids

      validation with: { form: true } do
        configure do
          predicates(ReformPredicates)

          def same_password?(value)
            value == form.password
          end
        end

        required(:firstname).filled
        required(:lastname).filled
        required(:email).filled
        required(:type).filled
        required(:password).filled
        required(:password_confirmation).filled(:same_password?)
        required(:project_ids)
      end
    end
  end
end
