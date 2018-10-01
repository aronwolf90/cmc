# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::IndexCsvOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:user) { build_stubbed(:user, records: [record]) }
  let(:record) { build_stubbed(:record) }

  it "model option is equal to record_days" do
    expect(subject[:model]).to eq([record])
  end
end
