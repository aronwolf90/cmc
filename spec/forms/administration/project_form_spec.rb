# frozen_string_literal: true

require "rails_helper"

describe Administration::ProjectForm do
  subject { described_class.new(project) }

  let(:project) { build_stubbed(:project) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(name: nil)).to be false }
end
