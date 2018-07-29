# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::WikiPagesController, type: :controller do
  let(:model) { build_stubbed(:wiki_page) }

  include_examples "standard show action"
  include_examples "standard update action",
    Api::V1::WikiPages::UpdateOperation
end
