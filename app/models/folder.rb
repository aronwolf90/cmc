# frozen_string_literal: true

class Folder < ApplicationRecord
  acts_as_paranoid

  belongs_to :folder
  belongs_to :project
  has_many :folders, -> { order(:name) }, dependent: :destroy
  has_many :documents, -> { order(:name) }, dependent: :destroy

  def root?
    folder_id.nil?
  end
end
