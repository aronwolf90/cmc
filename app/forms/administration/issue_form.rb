# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class IssueForm < ApplicationForm
    model ::Issue

    property :title
    property :description
    property :board_list_id

    validates :title, presence: true
    validates :description, presence: true
    validates :board_list_id, presence: true
  end
end
