# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :issue_labels
end
