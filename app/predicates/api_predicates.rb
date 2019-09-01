# frozen_string_literal: true

module ApiPredicates
  include Dry::Logic::Predicates

  predicate(:record_exists?) do |value|
    value.dig(:type)&.singularize
      &.underscore&.camelize&.constantize&.exists?(value&.dig(:id))
  end

  predicate(:numeric_format?) do |value|
    value.numeric?
  end

  predicate(:present?) do |value|
    value.present?
  end
end
