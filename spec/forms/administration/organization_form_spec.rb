# frozen_string_literal: true

require "rails_helper"

describe Administration::OrganizationForm do
  subject { described_class.new(organization) }

  let(:organization) { build_stubbed(:organization) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(time_zone: nil)).to be false }
  it { expect(subject.validate(time_zone: "")).to be false }
end
