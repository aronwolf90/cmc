# frozen_string_literal: true

require "rails_helper"

RSpec.describe SqlSpendedTimeCalculator do
  subject { described_class.call(Record.all) }

  before do
    Timecop.freeze
    create(
      :record,
      start_time: Time.zone.now,
      end_time: 1.hour.from_now
    )
    create(
      :record,
      start_time: 1.hour.from_now,
      end_time: 2.hours.from_now
    )
  end

  before { Timecop.return }

  it { is_expected.to eq 7200.seconds }
end
