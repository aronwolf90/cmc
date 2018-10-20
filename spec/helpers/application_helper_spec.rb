# frozen_string_literal: true

require "rails_helper"

describe ApplicationHelper do
  describe "#flash_class" do
    context "pass :notice as parameter" do
      it { expect(helper.flash_class(:notice)).to eq "alert alert-info" }
    end

    context "pass :success as parameter" do
      it { expect(helper.flash_class(:success)).to eq "alert alert-success" }
    end

    context "pass :error as parameter" do
      it { expect(helper.flash_class(:error)).to eq "alert alert-danger" }
    end

    context "pass :alert as parameter" do
      it { expect(helper.flash_class(:alert)).to eq "alert alert-warn" }
    end
  end

  describe "organization_sign_in_url" do
    let(:organization) { Organization.new(name: "main") }

    it "return root sign in url" do
      expect(helper.organization_sign_in_url(organization))
        .to eq "http://main.test.host/users/sign_in"
    end
  end
end
