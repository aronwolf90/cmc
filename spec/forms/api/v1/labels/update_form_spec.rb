# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Labels::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          name: "name",
          color: "#ff0000"
        }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  it "is invalid if the name is blank" do
    params[:data][:attributes][:name] = ""

    expect(subject).to be_failure
  end

  it "is invalid if the color is blank" do
    params[:data][:attributes][:color] = ""

    expect(subject).to be_failure
  end
end
