# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class WikiPageForm < Reform::Form
    feature Coercion
    model WikiPage

    property :title
    property :wiki_category_id

    validation do
      configure do
        predicates(ReformPredicates)
      end

      required(:title).filled
      required(:wiki_category_id).filled
    end
  end
end
