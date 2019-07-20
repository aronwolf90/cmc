# frozen_string_literal: true

require "rails_helper"

RSpec.describe Organization, type: :model do
  context "when already a organization with the same name exists" do
    before { create(:organization, name: "test") }

    it "creating a new one raise an error" do
      expect do
        create(:organization, name: "test")
      end.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "#to_s" do
    subject { Organization.new(name: "test").to_s }

    it "returns the name" do
      is_expected.to eq "test"
    end
  end
end
