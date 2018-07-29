# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::FoldersController, type: :controller do
  let(:model) { build_stubbed(:folder)  }

  include_examples "standard index action"
end
