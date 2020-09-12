# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Labels::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          name: "warning",
          color: "#FFFF00"
        }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when project is null" do
    before { params[:data][:attributes][:name] = nil }

    it "it has an error" do
      expect(subject).to be_failure
    end
  end

  context "with invalid project id" do
    before { params[:data][:attributes][:color] = nil }

    it "it has an error: id must be filled" do
      expect(subject).to be_failure
    end
  end
end
