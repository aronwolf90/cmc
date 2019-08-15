# frozen_string_literal: true

require "rails_helper"

RSpec.describe Contact, type: :model do
  it { is_expected.to belong_to :contact_avatar }

  describe ".search" do
    it "search partial words" do
      contact = create(:contact, name: "Test")

      expect(Contact.search("te")).to eq([contact])
    end
  end
end
