# frozen_string_literal: true

require "rails_helper"

RSpec.describe CreateNotificationsJob, type: :model do
  subject { described_class.new.perform(organization_id: organization.id) }

  let(:organization) { Organization.new(name: "test", id: 1) }

  before do
    allow(Organization).to receive(:find_by).and_return(organization)
    allow(Apartment::Tenant).to receive(:switch).and_yield
  end

  it "calls Jobs::CreateNotificationsOperation" do
    expect(Jobs::CreateNotificationsOperation).to receive(:call)

    subject
  end
end
