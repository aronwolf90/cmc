# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ProjectRecords::IndexOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { build_stubbed(:user) }
  let(:project) { build_stubbed(:project) }

  before do
    allow(Administration::ProjectRecords::ProjectStep).to receive(:call) do |options|
      options[:project] = project
    end
    allow(Administration::ProjectRecords::ThisMonthSpentTimeStep).to receive(:call) do |options|
      options["this_month_spended_time"] = 0
    end

    allow(Administration::ProjectRecords::IndexModelStep).to receive(:call) do |options|
      options["model"] = []
    end
  end

  it "model option is equal to record_days" do
    expect(subject["model"]).to eq([])
  end

  it "this_month_spended_time has correct value" do
    expect(subject["this_month_spended_time"]).to eq(0)
  end
end
