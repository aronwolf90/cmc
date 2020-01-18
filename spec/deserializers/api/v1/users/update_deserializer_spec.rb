# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Users::UpdateDeserializer do
  subject { described_class.normalize(params) }

  context "when selected_project is present" do
    let(:params) do
      {
        id: "1",
        type: "users",
        attributes: {
          firstname: "Lara",
          lastname: "Croft",
          email: "test@lvh.me"
        },
        relationships: {
          "selected-project": {
            data: {
              id: "1",
              type: "projects"
            }
          }
        }
      }
    end
    let(:result) do
      {
        selected_project_id: "1",
        firstname: "Lara",
        lastname: "Croft",
        email: "test@lvh.me"
      }
    end

    it "deserialized correctly" do
      expect(subject).to eq(result)
    end
  end

  context "when selected_project is nil" do
    let(:params) do
      {
        id: "1",
        type: "users",
        relationships: { "selected-project": { data: nil } }
      }
    end
    let(:result) do
      {
        selected_project_id: nil
      }
    end

    it "deserialized correctly" do
      expect(subject).to eq(result)
    end
  end
end
