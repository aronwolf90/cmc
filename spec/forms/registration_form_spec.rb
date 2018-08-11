# frozen_string_literal: true

require "rails_helper"

describe RegistrationForm do
  subject do
    described_class.new(organization: organization, user: user)
  end

  let(:organization) { build(:organization) }
  let(:user) { build(:user) }

  let(:valid_params) do
    {
      name: "test",
      firstname: "Bob",
      lastame: "Marley",
      email: "test@email.com",
      password: "password",
      confirmation_password: "password"
    }
  end

  it { expect(subject.validate(valid_params)).to be true }
end
