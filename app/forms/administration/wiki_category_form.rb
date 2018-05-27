# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class WikiCategoryForm < Reform::Form
    feature Coercion
    model WikiCategory

    property :title
    property :wiki_category_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:title).filled
    end
  end
end
