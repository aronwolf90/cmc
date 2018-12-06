# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class BoardListForm < ApplicationForm
    model BoardList

    property :name
    property :project_id

    validates :name, presence: true
  end
end
