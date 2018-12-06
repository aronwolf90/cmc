# frozen_string_literal: true

require "reform/form/coercion"

class ApplicationForm < Reform::Form
  feature Coercion

  def call(*args)
    validate(*args)
    self
  end

  def success?
    errors.none?
  end
end
