# frozen_string_literal: true

require "rails_helper"

describe Api::V1::WikiCategories::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        id: "1",
        type: "wiki-categories",
        attributes: {
          title: "Title"
        },
        relationships: {
          "wiki-category": {
            data: {
              id: "1",
              type: "wiki-categories"
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

  context "when attributes.title in blank" do
    before { params[:data][:attributes][:title] = "" }

    it "form is invalid" do
      expect(subject).to be_failure
    end
  end
end
