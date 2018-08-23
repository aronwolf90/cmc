# frozen_string_literal: true

module Registrations
  class CreateOperation < ApplicationOperation
    @form = RegistrationForm
    include MvcStandardCreateOperationConcern
  end
end
