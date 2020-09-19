# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe RegistrationsController do
  let(:model) do
    Registration.new(organization: Organization.new(name: "test"))
  end
  let(:form) { RegistrationForm }

  include_examples "standard new action", Registrations
  include_examples "standard create action", Registrations,
                   "http://test.test.host/users/sign_in"

  describe "POST create" do
    subject { post :create, params: { data: { name: "test" } } }

    before { sign_in Admin.new }

    context "when the operation succedes" do
      before do
        allow(Registrations::CreateOperation)
          .to receive(:call)
          .and_return(
            double(
              success?: true,
              "[]": double(organization: Organization.new(name: "test"))
            )
          )
      end

      specify do
        expect(subject)
          .to redirect_to("http://test.test.host/users/sign_in")
        expect(session["organization_display_name"])
          .to eq "test"
      end
    end

    context "when the operation fails" do
      before do
        allow(Registrations::CreateOperation)
          .to receive(:call)
          .and_return(
            double(
              success?: false,
              "[]": double(organization: Organization.new(name: "test"))
            )
          )
      end

      specify do
        expect(subject).to render_template :form
      end
    end
  end
end
