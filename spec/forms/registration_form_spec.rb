# frozen_string_literal: true

require "rails_helper"

describe RegistrationForm do
  subject do
    described_class.new(Registration.new)
  end

  let(:valid_params) do
    {
      name: "Test Name",
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
    before do
      allow(Organization)
        .to receive(:exists?).with(name: "test-name").and_return true
    end

    specify do
      expect(subject.validate(valid_params)).to be false
    end
  end

  context "organization name is in a blacklist" do
    before do
      allow(Settings).to receive(:organization_blacklist).and_return %w[about]
    end

    let(:invalid_params) { valid_params.merge(name: "about") }

    specify do
      expect(subject.validate(invalid_params)).to be false
    end
  end
end
