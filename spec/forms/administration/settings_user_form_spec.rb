# frozen_string_literal: true

require "rails_helper"

describe Administration::SettingsUserForm do
  subject { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(firstname: nil)).to be false }
  it { expect(subject.validate(lastname: nil)).to be false }
  it { expect(subject.validate(email: nil)).to be false }
  it { expect(subject.validate(telephon_number: nil)).to be true }
end
