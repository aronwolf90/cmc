# frozen_string_literal: true

require "rails_helper"

describe Administration::Users::ConfigurationForm do
  subject { described_class.new(user) }

  let(:user) do
    build_stubbed(
      :admin,
      password: "testtest",
      password_confirmation: "testtest"
    )
  end

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(type: "Admin")).to be true }
  it { expect(subject.validate(project_ids: [])).to be true }
end
