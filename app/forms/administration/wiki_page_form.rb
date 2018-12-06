# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class WikiPageForm < ApplicationForm
    model WikiPage

    property :title
    property :wiki_category_id

    validates :title, presence: true
    validates :wiki_category_id, presence: true
  end
end
