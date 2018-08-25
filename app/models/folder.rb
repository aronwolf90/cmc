# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :folder
  has_many :folders, -> { order(:name) }
  has_many :documents, -> { order(:name) }

  def root?
    folder.nil?
  end
end
