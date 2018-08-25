# frozen_string_literal: true

require "reform/form/coercion"

module Administration
  class SettingsUserConfigurationForm < Reform::Form
    feature Coercion
    model User

    property :type
    property :project_ids

    validation with: { form: true } do
      configure do
        predicates(ReformPredicates)
      end

      required(:type).filled
      required(:project_ids)
    end
  end
end
