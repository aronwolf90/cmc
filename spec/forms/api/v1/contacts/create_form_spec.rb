# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Contacts::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          "lastname": "Name",
          "firstname": "Frantz",
          "address_city": "Augsburg",
          "address_zip": "86153",
          "address_country": "germany",
          "address_steet": "Street",
          "address_number": "8"
        }
      }
    }
  end

  context "with valid params" do
    it { is_expected.to be_success }
  end
end
