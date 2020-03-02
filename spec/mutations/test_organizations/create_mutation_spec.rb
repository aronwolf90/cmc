# frozen_string_literal: true

require "rails_helper"

RSpec.describe TestOrganizations::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      global_board: global_board
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { build(:organization) }
  let(:global_board) { true }

  it "create the organization and the tenant" do
    expect(Organizations::CreateMutation)
      .to receive(:call).with(
        model: model,
        name: "test-organization",
        time_zone: "Berlin",
        global_board: true
      )

    subject
  end
end
