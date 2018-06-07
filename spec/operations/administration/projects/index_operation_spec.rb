# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::IndexOperation do
  subject { described_class.() }

  before do
    allow(Project).to receive(:all).and_return([])
  end

  it "model is set" do
    expect(subject["model"]).to eq([])
  end
end
