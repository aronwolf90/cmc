# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class BoardListForm < Reform::Form
    property :name
    property :project_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:name).filled
    end
  end
end
