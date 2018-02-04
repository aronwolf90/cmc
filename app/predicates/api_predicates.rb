module ApiPredicates
  include Dry::Logic::Predicates

  predicate(:record_exists?) do |value|
    value.dig(:data)&.dig(:type)&.singularize
      &.underscore&.camelize&.constantize&.exists?(value.dig(:data)&.dig(:id))
  end
end
