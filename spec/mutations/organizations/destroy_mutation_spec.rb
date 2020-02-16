# frozen_string_literal: true

require "rails_helper"

describe Organizations::DestroyMutation do
  subject do
    described_class.call(
      user: current_user,
      model: organization
    )
  end

  let!(:organization) { create(:organization) }
  let(:current_user) { create(:admin) }

  it "destroy the organization" do
    expect { subject }.to change(Organization, :count).to(0)
  end
end
