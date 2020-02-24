# frozen_string_literal: true

require "rails_helper"

RSpec.describe CreateNotificationsJob, type: :model do
  subject { described_class.new.perform(organization: organization)  }

  let(:organization) { Organization.new(name: "test") }

  before { allow(Apartment::Tenant).to receive(:switch).and_yield }

  it "calls Jobs::CreateNotificationsOperation" do
    expect(Jobs::CreateNotificationsOperation).to receive(:call)

    subject
  end
end
