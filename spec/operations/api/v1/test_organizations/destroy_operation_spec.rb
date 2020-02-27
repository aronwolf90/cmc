# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::TestOrganizations::DestroyOperation do
  subject do
    described_class.call
  end

  let(:organization) { Organization.new }

  before do
    allow(::Organizations::DestroyMutation)
      .to receive(:call)
  end

  it "calls destroy mutation when the organization exists" do
    allow(Organization).to receive(:find_by).and_return organization
    subject
    expect(Organizations::DestroyMutation)
      .to have_received(:call)
      .with(model: organization)
  end

  it "does not call destroy mutation when the organization does not exist" do
    allow(Organization).to receive(:find_by).and_return nil
    subject
    expect(Organizations::DestroyMutation)
      .not_to have_received(:call)
  end
end
