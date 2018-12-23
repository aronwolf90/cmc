# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdminArea::Organizations::IndexOperation do
  subject { described_class.(current_user: current_user) }

  let(:current_user) { Admin.new }

  before do
    allow(Organization).to receive(:all).and_return([])
  end

  it "model is set" do
    expect(subject["model"]).to eq([])
  end
end
