# frozen_string_literal: true

require "rails_helper"

RSpec.describe TestOrganizations::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { build(:organization) }

  it "create the organization and the tenant" do
    expect(Organizations::CreateMutation)
      .to receive(:call).with(
        model: model,
        name: "test-organization",
        time_zone: "Berlin"
      )

    subject
  end
end
