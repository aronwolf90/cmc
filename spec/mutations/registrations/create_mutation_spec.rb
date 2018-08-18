# frozen_string_literal: true

require "rails_helper"

RSpec.describe Registrations::CreateMutation do
  subject do
    described_class.call(
      attributes: attributes,
      current_user: current_user,
      model: { organization: Organization.new, user: Admin.new }
    )
  end

  let(:current_user) { create(:admin) }
  let(:attributes) do
    {
      organization: {
        name: "test",
        time_zone: "Berlin"
      },
      user: {
        firstname: "Bob",
        lastname: "Marley",
        email: "bob@email.com",
        password: "password",
        confirmation_password: "password"
      }
    }
  end


  it "create the organization, the tenant and the user" do
    expect(Apartment::Tenant).to receive(:create).with("test")
    expect(Apartment::Tenant).to receive(:switch).with("test").and_yield

    expect { subject }.to change(Organization, :count).by(1)
      .and change(User, :count)
  end
end
