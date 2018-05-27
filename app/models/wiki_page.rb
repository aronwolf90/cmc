# frozen_string_literal: true

# frotzen_string_literal: true

class WikiPage < ApplicationRecord
  belongs_to :wiki_category
end
