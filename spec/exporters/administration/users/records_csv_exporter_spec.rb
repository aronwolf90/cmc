# frozen_string_literal: true

require "rails_helper"

describe Administration::Users::RecordsCsvExporter do
  subject { described_class.([record]) }

  let(:record) { build_stubbed(:record) }
  let(:project) { build_stubbed(:project) }

  before do
    allow(record).to receive(:project).and_return(project)
  end

  it { is_expected.to include project.to_s  }
  it { is_expected.to include record.description  }
  it { is_expected.to include record.start_time.to_s  }
  it { is_expected.to include record.end_time.to_s  }
  it { is_expected.to include "00:01:00" }
end
