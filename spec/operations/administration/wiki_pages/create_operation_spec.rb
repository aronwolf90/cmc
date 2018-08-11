# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_create_operation"

RSpec.describe Administration::WikiPages::CreateOperation do
  it_should_behave_like "standard create operation",
    Administration::WikiPageForm,
    {
      data: {
        title: "title",
        wiki_category_id: 1
      }
    },
    {
      data: {
        title: nil
      }
    }
end
