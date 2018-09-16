# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Records::IndexOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { build_stubbed(:user, record_days: RecordDay.none) }

  before do
    allow(User).to receive(:find).and_return(user)
  end

  it "model option is equal to record_days" do
    expect(subject["model"]).to eq([])
  end

  it "this_month_spended_time has correct value" do
    expect(subject[:this_month_spended_time]).to eq(0)
  end
end
