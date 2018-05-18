# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class IssueForm < Reform::Form
    model ::Issue

    property :title
    property :description
    property :board_list_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:title).filled
      required(:description).filled
      required(:board_list_id).filled
    end
  end
end
