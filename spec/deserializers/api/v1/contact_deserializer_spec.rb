# frozen_string_literal: true

require "rails_helper"

describe Api::V1::ContactDeserializer do
  subject { described_class.normalize(params) }

  let(:params) do
    {
      attributes: {
        name: "Frantz",
        description: "Description",
        telephone: "01727873609",
        mobile: "01702876609",
        fax: "01727876620",
        "address-city": "Augsburg",
        "address-zip": "86153",
        "address-country": "germany",
        "address-street": "Street",
        "address-number": "8",
        "contact-avatar-id": "1"
      }
    }
  end
  let(:result) do
    {
      name: "Frantz",
      description: "Description",
      telephone: "01727873609",
      mobile: "01702876609",
      fax: "01727876620",
      address_city: "Augsburg",
      address_zip: "86153",
      address_country: "germany",
      address_street: "Street",
      address_number: "8",
      contact_avatar_id: "1"
    }
  end

  context "with comment in JSON-APi format" do
    it "deserialize to the Active Record format" do
      expect(subject).to eq(result)
    end
  end
end
