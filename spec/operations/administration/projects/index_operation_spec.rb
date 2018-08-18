# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::IndexOperation do
  subject { described_class.(current_user: current_user) }

  let(:current_user) { build_stubbed(:admin) }

  before do
    allow(ProjectPolicy::Scope).to receive(:call).and_return([])
  end

  it "model is set" do
    expect(subject["model"]).to eq([])
  end
end
