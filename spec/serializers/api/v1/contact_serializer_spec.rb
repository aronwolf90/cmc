# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContactSerializer, type: :serializer do
  let(:contact) do
    build_stubbed(
      :contact,
      name: "Frantz",
      email: "test@example.com",
      description: "Test description",
      telephone: "01707986607",
      mobile: "01707986617",
      fax: "01707986617",
      address_city: "Augsburg",
      address_zip: "86153",
      address_country: "germany",
      address_street: "Street",
      address_number: "8",
      contact_avatar: contact_avatar
    )
  end
  let(:contact_avatar) do
    build_stubbed(:contact_avatar,
      file: File.open(Rails.root.join("spec", "fixtures", "avatar.png"))
    )
  end

  let(:expected_avatar_url) do
    "/api/v1/contact_avatars/#{contact_avatar.id}"
  end
  let(:expected_result) do
    {
      data: {
        id: contact.id.to_s,
        type: "contacts",
        attributes: {
          name: "Frantz",
          email: "test@example.com",
          description: "Test description",
          telephone: "01707986607",
          mobile: "01707986617",
          fax: "01707986617",
          "address-city": "Augsburg",
          "address-zip": "86153",
          "address-country": "germany",
          "address-street": "Street",
          "address-number": "8",
          "avatar-url": expected_avatar_url
        },
        links: { self: "/api/v1/contacts/#{contact.id}" }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(contact)).to eql expected_result
  end

  context "when contact_avatar is nil" do
    let(:contact_avatar) { nil }
    let(:expected_avatar_url) do
      "/api/v1/contact_avatars/placeholder"
    end

    it "return a placeholder avatar" do
      expect(serialize(contact)).to eql expected_result
    end
  end
end
