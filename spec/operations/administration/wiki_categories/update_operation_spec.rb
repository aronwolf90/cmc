# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_update_operation"

RSpec.describe Administration::WikiCategories::UpdateOperation do
  subject { described_class.(params: params) }

  let(:wiki_category) { build_stubbed(:wiki_category) }

  before do
    allow(WikiCategory).to receive(:find).and_return(wiki_category)
  end

  it_should_behave_like "standard update operation",
    Administration::WikiCategoryForm,
      {
        data: {
          name: "name"
        }
      },
      {
        data: {
          name: nil
        }
      }
end
