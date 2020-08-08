# frozen_string_literal: true

require "rails_helper"

RSpec.describe Registrations::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: Registration.new,
      **attributes,
    )
  end

  let(:current_user) { create(:admin) }
  let(:attributes) do
    {
      name: "test",
      time_zone: "Berlin",
      firstname: "Bob",
      lastname: "Marley",
      email: "bob@email.com",
      password: "password",
      confirmation_password: "password"
    }
  end


  it "create the organization, the tenant and the user" do
    expect(Apartment::Tenant).to receive(:create).with("test")
    expect(Apartment::Tenant).to receive(:switch).with("test").and_yield

    expect do
      registration = subject
      expect(registration.organization).to be_a(Organization)
      expect(registration.user).to be_a(User)
    end
      .to change(Organization, :count).by(1)
      .and change(User, :count)
  end
end
