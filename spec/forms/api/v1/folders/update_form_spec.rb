# frozen_string_literal: true

require "rails_helper"

describe Api::V1::Folders::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          "name": "Name"
        }
      }
    }
  end

  context "with valid params" do
    it { is_expected.to be_success }
  end

  context "without name" do
    before { params[:data][:attributes][:name] = nil }

    it { is_expected.to be_success }
  end
end
