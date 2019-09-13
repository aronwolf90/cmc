# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::WikiPages::UpdateOperation do
  include_examples "standard api update operation",
                   form: Api::V1::WikiPages::UpdateForm,
                   model: WikiPage.new,
                   deserializer: Api::V1::WikiPageDeserializer
end
