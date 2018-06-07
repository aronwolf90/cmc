# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::SettingsUsers::UpdateOperation do
  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:current_user) { build_stubbed(:user) }

  before do
    allow(Administration::SettingsUserForm)
      .to receive(:new).and_return(form)
    allow(User).to receive(:find).and_return(current_user)
    allow(form).to receive(:save).and_return(true)
  end

  context "valid params" do
    let(:params) do
      {
        data: {
          firstname: "firstname",
          lastname: "lastname",
          email: "test@test.com"
        }
      }
    end
    let(:form) { double()  }

    before do
      result = double(success?: true)
      allow(form).to receive(:call).and_return(result)
    end

    it { is_expected.to be_success }

    it "save is called on form object" do
      subject
      expect(form).to have_received(:save)
    end
  end

  context "invalid params" do
    let(:params) do
      {
        data: {
          firstname: nil
        }
      }
    end
    let(:form) { double() }

    before do
      allow(form).to receive(:call).and_return(double(success?: false))
    end

    it { is_expected.to be_failure }

    it "save is not called on form object" do
      subject
      expect(form).not_to have_received(:save)
    end
  end
end
