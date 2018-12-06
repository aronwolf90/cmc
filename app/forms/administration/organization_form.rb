# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class OrganizationForm < ApplicationForm
    model Organization

    property :time_zone

    validates :time_zone, presence: true
  end
end
