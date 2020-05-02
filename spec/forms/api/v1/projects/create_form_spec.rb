# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Projects::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          name: "Test"
        },
        "relationships": {
          "contact": {
            "data": {
              "attributes": {
                name: "Test name",
                description: "Test name"
              }
            }
          }
        }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when name is nil" do
    before { params[:data][:attributes][:name] = nil }

    it "form is invalid" do
      expect(subject).to be_failure
    end
  end

  context "when context name in not present" do
    before do
      params.dig(
        :data,
        :relationships,
        :contact,
        :data,
        :attributes
      )[:name] = nil
    end

    it "form is invalid" do
      expect(subject).to be_failure
    end
  end
end
