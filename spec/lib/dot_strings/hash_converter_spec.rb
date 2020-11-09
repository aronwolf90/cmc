# frozen_string_literal: true

require "rails_helper"

RSpec.describe DotStrings::HashConverter do
  subject { described_class.call(dot_strings) }

  let(:dot_strings) do
    %w[issues.labels projects]
  end

  it "converts dot strings to a hash" do
    expect(subject).to eq(
      issues: { labels: {} },
      projects: {}
    )
  end
end
