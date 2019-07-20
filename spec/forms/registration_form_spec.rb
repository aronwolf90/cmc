# frozen_string_literal: true

require "rails_helper"

describe RegistrationForm do
  subject do
    described_class.new(Registration.new)
  end

  let(:valid_params) do
    {
      name: "test",
      time_zone: "Berlin",
      firstname: "Bob",
      lastname: "Marley",
      email: "test@email.com",
      password: "password",
      confirmation_password: "password",
      terms_service: true
    }
  end

  specify do
    expect(subject.validate(valid_params)).to be true
  end

  specify do
    expect(subject.validate({})).to be false
  end

  context "diferent passwords" do
    let(:invalid_params) { valid_params.merge(confirmation_password: "123") }

    specify do
      expect(subject.validate(invalid_params)).to be false
    end
  end

  context "organization already exists" do
    before { allow(Organization).to receive(:exists?).and_return true }

    specify do
      expect(subject.validate(valid_params)).to be false
    end
  end
end
