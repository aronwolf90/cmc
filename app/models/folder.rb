# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :folder
  has_many :folders
  has_many :documents

  def root?
    folder.nil?
  end
end
