# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::IndexModelStep do
  subject do
    described_class.call(
      options,
      params: {},
      current_user: current_user
    )
  end

  let(:current_user) { create(:admin) }
  let(:options) { {} }

  before do
    create(:record, user: current_user)
    create(:organization, name: "public")
    subject
  end

  it "set on options the correct spended Time" do
    expect(options["model"].as_json).to eq([RecordDay.first.as_json])
  end
end
