# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :folder
  has_many :folders, -> { order(:name) }, dependent: :destroy
  has_many :documents, -> { order(:name) }, dependent: :destroy

  def root?
    folder_id.nil?
  end
end
