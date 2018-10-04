# frozen_string_literal: true

class WikiCategory < ApplicationRecord
  belongs_to :wiki_category
  has_many :wiki_categories, -> { order(:title) }, dependent: :destroy
  has_many :wiki_pages, -> { order(:title) }, dependent: :destroy

  def root?
    wiki_category_id.nil?
  end

  def to_s
    title
  end
end
