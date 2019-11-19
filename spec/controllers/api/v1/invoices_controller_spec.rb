# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::InvoicesController, type: :controller do
  let(:model) { Invoice.new(id: 1) }

  before do
    allow(Organization)
      .to receive(:invoices).and_return([model])
  end

  include_examples "standard api index action"
end
