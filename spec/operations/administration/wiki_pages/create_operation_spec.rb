# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_create_operation"

RSpec.describe Administration::WikiPages::CreateOperation do
  let(:model) { WikiPage.new }

  it_should_behave_like "standard create operation",
    form_class: Administration::WikiPageForm
end
