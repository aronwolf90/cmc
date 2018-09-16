# frozen_string_literal: true

require "rails_helper"

describe Administration::RecordsCsvExporter do
  subject { described_class.([record]) }

  let(:record) { build_stubbed(:record) }

  it { is_expected.to include record.start_time.to_s  }
  it { is_expected.to include record.end_time.to_s  }
  it { is_expected.to include "00:01:00" }
end
