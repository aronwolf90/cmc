# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::IndexOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { build_stubbed(:user) }

  before do
    allow(Administration::Records::ThisMonthSpentTimeStep).to receive(:call) do |options|
      options["this_mounth_spended_time"] = 0
    end

    allow(Administration::Records::ModelStep).to receive(:call) do |options|
      options["model"] = []
    end
  end

  it "model option is equal to record_days" do
    expect(subject["model"]).to eq([])
  end

  it "this_mounth_spended_time has correct value" do
    expect(subject["this_mounth_spended_time"]).to eq(0)
  end
end
