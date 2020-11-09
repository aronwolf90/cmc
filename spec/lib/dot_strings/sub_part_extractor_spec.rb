# frozen_string_literal: true

require "rails_helper"

RSpec.describe DotStrings::SubPartExtractor do
  subject { described_class.call(dot_strings, "issues") }

  let(:dot_strings) do
    %w[issues.labels projects]
  end

  it "converts dot strings to a hash" do
    expect(subject).to eq(["labels"])
  end
end
