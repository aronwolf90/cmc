# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Projects::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          name: "Test"
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
end
