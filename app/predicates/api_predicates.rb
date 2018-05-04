# frozen_string_literal: true

module ApiPredicates
  include Dry::Logic::Predicates

  predicate(:record_exists?) do |value|
    value.dig(:data, :type)&.singularize
      &.underscore&.camelize&.constantize&.exists?(value.dig(:data, :id))
  end

  predicate(:numeric_format?) do |value|
    value.numeric?
  end
end
