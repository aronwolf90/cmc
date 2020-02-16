# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::OrganizationSerializer, type: :serializer do
  let(:organization) do
    Organization.new(
      id: 1,
      name: "Organization name",
    )
  end
  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "organizations",
        attributes: {
          name: "Organization name"
        }
      }
    }
  end

  it "serialize organization in the correct way" do
    expect(serialize(organization)).to eql expected_result
  end
end
