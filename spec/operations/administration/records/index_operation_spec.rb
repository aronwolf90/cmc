# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::IndexOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { User.new }

  before do
    allow(Administration::Records::ThisMonthSpentTimeStep).to receive(:call) do |options|
      options["this_month_spended_time"] = 0
    end

    allow(Paginator).to receive(:call).and_return([])
    allow(Administration::Records::Preloader)
      .to receive(:call).and_return([])
  end

  it "model option is equal to record_days" do
    expect(subject["model"]).to eq([])
  end

  it "this_month_spended_time has correct value" do
    expect(subject["this_month_spended_time"]).to eq(0)
  end
end
