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

  describe "#asside_item" do
    subject do
      helper.asside_item(
        "Projects",
        path: administration_projects_path,
        policy: true
      )
    end

    specify do
      is_expected.to eq "<li><a href=\"/administration/projects\">Projects</a></li>"
    end
  end

  describe "#top_asside_item" do
    subject do
      helper.top_asside_item(
        "Projects",
        icon: :building,
        path: administration_projects_path
      )
    end

    specify do
      is_expected.to eq "<li><a href=\"/administration/projects\"><i class=\"fa fa-building fa-lg\"></i>&nbsp &nbsp Projects</a></li>"
    end
  end
end
