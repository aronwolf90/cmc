# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:model) { build_stubbed(:comment)  }

  include_examples "standard api create action",
    Api::V1::Comments::CreateOperation
end
