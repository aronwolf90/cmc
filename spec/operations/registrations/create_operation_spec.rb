# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe Registrations::CreateOperation do
  subject(:call) { described_class.call(params: params, current_user: nil, recaptcha: recaptcha) }

  let(:params) do
    {
      data: {
        name: "Test Name",
        time_zone: "Berlin",
        firstname: "Bob",
        lastname: "Marley",
        email: "test@email.com",
        password: "password",
        confirmation_password: "password",
        terms_service: true
      }
    }
  end
  let(:organization) { Organization.new(id: 1) }
  let(:user) { Admin.new(id: 1) }
  let(:recaptcha) { true  }

  before do
    result = double(success?: true)
    form = double(call: result)
    allow(RegistrationForm)
      .to receive(:new).and_return(form)
    allow(result).to receive(:save).and_yield({})
    allow(Organization).to receive(:find).and_return(organization)
  end

  specify do
    expect(Registrations::CreateMutation)
      .to receive(:call)
      .and_return(
        Registration.new(
          organization: organization,
          user: user
        )
      )

    expect { call }.to have_enqueued_job
  end

  context "recaptcha is false" do
    let(:recaptcha) { false }

    specify do
      expect(Registrations::CreateMutation)
        .not_to receive(:call)
      expect(call.failure?).to eq true
    end
  end
end
