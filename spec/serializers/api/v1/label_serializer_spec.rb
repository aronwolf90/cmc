# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::LabelSerializer, type: :serializer do
  let(:invoice) do
    Label.new(
      id: 1,
      name: "warning",
      color: "  #FFFF00"
    )
  end

  let(:expected_result) do
    {
      data: {
        id: "1",
        type: "labels",
        attributes: {
          name: "warning",
          color: "  #FFFF00"
        },
        links: {
          self: "/api/v1/labels/1"
        }
      }
    }
  end

  it "serialize an invoice in the correct way" do
    expect(serialize(invoice)).to eq expected_result
  end
end
