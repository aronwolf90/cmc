# frozen_string_literal: true

require "rails_helper"

RSpec.describe OrganizationMailer, type: :mailer do
  describe "#wellcome" do
    subject(:mail) do
      described_class
        .with(user_id: user.id, organization: organization)
        .wellcome
        .deliver_now
    end

    let(:organization) { Organization.new(id: 1) }
    let(:user) do
      Admin.new(
        id: 1,
        firstname: "Lara",
        lastname: "Croft",
        email: "test@example.com"
      )
    end

    before do
      allow(Organization)
        .to receive(:find).with(organization.id).and_return(organization)
      allow(User)
        .to receive(:find).with(user.id).and_return(user)
    end

    specify do
      expect(mail.subject).to eq("Wellcome to Ticktensio")
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.body.encoded).to match("lvh.me")
      expect(mail.body.encoded).to match("Lara Croft")
    end
  end
end
