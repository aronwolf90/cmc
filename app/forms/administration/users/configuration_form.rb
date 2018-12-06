# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  module Users
    class ConfigurationForm < ApplicationForm
      feature Coercion
      model User

      property :type
      property :project_ids

      validates :type, presence: true
    end
  end
end
