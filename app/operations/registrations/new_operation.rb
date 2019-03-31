# frozen_string_literal: true

module Registrations
  class NewOperation < ApplicationOperation
    @form = RegistrationForm
    include MvcStandardNewOperationConcern
  end
end
