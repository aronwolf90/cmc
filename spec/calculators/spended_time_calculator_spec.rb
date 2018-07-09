# frozen_string_literal: true

require "rails_helper"

RSpec.describe SpendedTimeCalculator do
  subject { described_class.call([record1, record2]) }

  let(:record1) do
    build_stubbed(
      :record,
      start_time: Time.zone.now,
      end_time: 1.hour.from_now
    )
  end
  let(:record2) do
    build_stubbed(
      :record,
      start_time: 1.hour.from_now,
      end_time: 2.hour.from_now
    )
  end

  before { Timecop.freeze }
  before { Timecop.return }

  it { is_expected.to eq 7200.seconds }
end
