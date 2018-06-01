# frozen_string_literal: true

require "rails_helper"

describe Administration::UserForm do
  subject { described_class.new(user) }

  let(:user) do
    build_stubbed(
      :user,
      password: "testtest",
      password_confirmation: "testtest"
    )
  end

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(firstname: nil)).to be false }
  it { expect(subject.validate(lastname: nil)).to be false }
  it { expect(subject.validate(email: nil)).to be false }
  it { expect(subject.validate(password: nil)).to be false }
  it { expect(subject.validate(password_confirmation: nil)).to be false }
  it { expect(subject.validate(password_confirmation: "diferent")).to be false }
end
