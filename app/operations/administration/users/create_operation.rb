# frozen_string_literal: true

module Administration::Users
  class CreateOperation < BaseOperation
    include MvcStandardCreateOperationConcern
  end
end
