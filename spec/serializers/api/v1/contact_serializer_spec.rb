# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::ContactSerializer, type: :serializer do
  let(:contact) do
    build_stubbed(
      :contact,
      name: "Frantz",
      description: "Test description",
      telephone: "01707986607",
      mobile: "01707986617",
      fax: "01707986617",
      address_city: "Augsburg",
      address_zip: "86153",
      address_country: "germany",
      address_street: "Street",
      address_number: "8",
    )
  end

  let(:expected_result) do
    {
      data: {
        id: contact.id.to_s,
        type: "contacts",
        attributes: {
          name: "Frantz",
          description: "Test description",
          telephone: "01707986607",
          mobile: "01707986617",
          fax: "01707986617",
          "address-city": "Augsburg",
          "address-zip": "86153",
          "address-country": "germany",
          "address-street": "Street",
          "address-number": "8"
        },
        relationships: {
          "contact-avatar": {
            data: nil
          }
        },
        links: { self: "/api/v1/contacts/#{contact.id}" }
      }
    }
  end

  it "serialize record in the correct way" do
    expect(serialize(contact)).to eql expected_result
  end
end
