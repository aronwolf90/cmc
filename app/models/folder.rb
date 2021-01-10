# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :folder
  belongs_to :project
  has_many :folders, -> { order(:name) }, dependent: :destroy
  has_many :documents, -> { order(:name) }, dependent: :destroy

  pg_search_scope(
    :search,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }
  )

  def root?
    folder_id.nil?
  end
end
