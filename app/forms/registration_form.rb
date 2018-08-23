# frozen_string_literal: true

require "reform/form/coercion"

class RegistrationForm < Reform::Form
  feature Coercion
  model Registration

  property :name
  property :time_zone

  property :firstname
  property :lastname
  property :email
  property :password
  property :confirmation_password, virtual: true

  validation :default, with: { form: true } do
    configure do
      def same_password?(value)
        value == form.password
      end

      def password_length?(value)
        value.to_s.size >= 6
      end

      def uniq_organization_name?(value)
        !Organization.exists?(name: value)
      end
    end

    required(:name).filled(:uniq_organization_name?)
    required(:firstname).filled
    required(:lastname).filled
    required(:email)
    required(:password).filled(:password_length?)
    required(:confirmation_password).filled(:same_password?)
  end
end
