# frozen_string_literal: true

class WikiCategory < ApplicationRecord
  belongs_to :wiki_category
  has_many :wiki_categories
  has_many :wiki_pages

  def root?
    wiki_category.nil?
  end

  def to_s
    title
  end
end
