# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::DestroyOperation do
  subject { described_class.(params: {}) }

  let(:project) { build_stubbed(:project) }

  before do
    allow(Project).to receive(:find).and_return(project)
  end

  it "call destroy" do
    expect(project).to receive(:destroy!)
    subject
  end
end
