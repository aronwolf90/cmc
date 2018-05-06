# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ProjectForm < Reform::Form
    feature Coercion

    property :name

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:name).filled
    end
  end
end
