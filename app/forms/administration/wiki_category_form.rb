# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class WikiCategoryForm < ApplicationForm
    model WikiCategory

    property :title
    property :wiki_category_id

    validates :title, presence: true
  end
end
