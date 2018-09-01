# frozen_string_literal: true

require "rails_helper"

describe Administration::ProjectRecords::IndexModelStep do
  subject do
    described_class.call(
      options,
      params: {},
      current_user: current_user,
      project: project
    )
  end

  let(:current_user) { build_stubbed(:admin) }
  let(:project) { build_stubbed(:project) }
  let(:options) { {} }

  before do
    subject
  end

  it "set on options the correct spended Time" do
    expect(options["model"].as_json).to eq([])
  end
end
