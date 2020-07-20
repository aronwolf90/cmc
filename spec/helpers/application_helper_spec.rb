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

  describe "#left_menu" do
    subject do
      helper.left_menu { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<ul class="navbar-nav mr-auto ml-4"></br></ul>'
    end
  end

  describe "#menu" do
    subject do
      helper.menu { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<nav class="navbar navbar-expand-sm navbar-dark fixed-top"></br></nav>'
    end
  end

  describe "#right_menu" do
    subject do
      helper.right_menu { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<ul class="navbar-nav"></br></ul>'
    end
  end

  describe "#user_menu_dropdown_text" do
    subject do
      helper.user_menu_dropdown_text { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<a class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></br></a>'
    end
  end

  describe "#user_menu_dropdown_body" do
    subject do
      helper.user_menu_dropdown_body { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<div class="dropdown-menu dropdown-menu-right"></br></div>'
    end
  end

  describe "#dropdown_link" do
    subject do
      helper.dropdown_link "link", "/administration/projects"
    end

    specify do
      is_expected.to eq '<a class=" dropdown-item" href="/administration/projects">link</a>'
    end
  end

  describe "#asside" do
    subject do
      helper.asside(true) { "</br>".html_safe }
    end

    specify do
      is_expected.to eq '<div class="side-menu"><ul class="nav navbar-nav"></br></ul></div>'
    end
  end

  describe "#organization_url" do
    context "when multitenant is enabled" do
      before { allow(Settings).to receive(:multi_tenant).and_return(true) }

      it "return url with name as subdomain" do
        expect(helper.organization_url(build_stubbed(:organization, name: "test")))
          .to eq "http://test.lvh.me:3000"
      end
    end

    context "when multitenant is disabled" do
      before { allow(Settings).to receive(:multi_tenant).and_return(false) }

      it "return url with name as subdomain" do
        expect(helper.organization_url(build_stubbed(:organization, name: "test")))
          .to eq "http://lvh.me:3000"
      end
    end
  end

  describe "google_calender_notification_url" do
    specify do
      expect(helper.google_calender_notification_url("test"))
        .to eq("https://lvh.me:3000/google_calenders/notification?organization=test")
    end
  end
end
