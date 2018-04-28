# frozen_string_literal: true

module ReformPredicates
  include Dry::Logic::Predicates

  predicate(:exists?) do |klazz, id|
    klazz.exists?(id)
  end
end
