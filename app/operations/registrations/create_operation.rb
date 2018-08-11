# frozen_string_literal: true

module Registrations
  class CreateOperation < ApplicationOperation
    @form = RegistrationForm
    @mutation = Registrations::CreateMutation
    @model_step = Registrations::ModelStep
    include MvcStandardCreateOperationConcern
  end
end
