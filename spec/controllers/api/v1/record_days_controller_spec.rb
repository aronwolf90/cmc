# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::RecordDaysController, type: :controller do
  let(:model) { RecordDay.new(id: 1) }

  before do
    allow(RecordDay).to receive(:ordered).and_return(Kaminari.paginate_array([model]))
  end

  include_examples "standard api index action"
end
