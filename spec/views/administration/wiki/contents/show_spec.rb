# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/wiki/contents/show" do
  helper AdministrationHelper

  subject { rendered }

  before do
    sign_in(Admin.new)
    render
  end

  it { is_expected.to have_link("New wikicategory") }
  it { is_expected.to have_link("New wikipage") }
  it { is_expected.to have_selector("wiki-content") }
end
