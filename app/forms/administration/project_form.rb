# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class ProjectForm < ApplicationForm
    model ::Project

    property :name

    validates :name, presence: true
  end
end
