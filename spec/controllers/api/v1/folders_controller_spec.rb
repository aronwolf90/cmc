# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::FoldersController, type: :controller do
  let(:model) { Folder.new(id: 1)  }

  include_examples "standard api index action"
end
