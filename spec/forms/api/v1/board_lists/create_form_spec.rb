# frozen_string_literal: true

require "rails_helper"

describe Api::V1::BoardLists::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: { name: "name" }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end
end
