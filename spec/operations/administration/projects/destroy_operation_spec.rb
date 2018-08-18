# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::DestroyOperation do
  subject { described_class.(params: {}, current_user: user) }

  let(:project) { build_stubbed(:project) }
  let(:user) { build_stubbed(:admin) }

  before do
    allow(Project).to receive(:find).and_return(project)
  end

  it "call destroy" do
    expect(project).to receive(:destroy!)
    subject
  end
end
