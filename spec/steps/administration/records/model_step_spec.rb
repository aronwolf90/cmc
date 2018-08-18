# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::ModelStep do
  subject { described_class.call(options, params: {}, current_user: current_user) }

  let(:current_user) { create(:admin) }
  let(:options) { {} }

  before do
    create(:record, user: current_user)
    subject
  end

  it "set on options the correct spended Time" do
    expect(options["model"].as_json).to eq([RecordDay.first.as_json])
  end
end
