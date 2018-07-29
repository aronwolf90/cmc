# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::WikiCategoriesController, type: :controller do
  let(:model) { build_stubbed(:wiki_category) }

  include_examples "standard index action"
end
