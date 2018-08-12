# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class OrganizationForm < Reform::Form
    feature Coercion
    model Organization

    property :time_zone

    validation  do
      required(:time_zone).filled
    end
  end
end
