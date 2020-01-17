# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Users::Configuration::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        id: "1",
        type: "users",
        attributes: {
          type: "Admin"
        }
      }
    }
  end

  context "when type==Admin" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when type==Employee" do
    before { params[:data][:attributes][:type] = "Employee" }

    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when type==Customer" do
    before { params[:data][:attributes][:type] = "Customer" }

    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when type==invalid" do
    before { params[:data][:attributes][:type] = "invalid" }

    it "form is invalid" do
      expect(subject).to be_failure
    end
  end
end
