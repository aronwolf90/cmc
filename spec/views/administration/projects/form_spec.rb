# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/projects/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:user) { build_stubbed(:admin) }
  let(:form) { Administration::ProjectForm.new(project) }
  let(:project) { build_stubbed(:project) }

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it "add new btn is present" do
    is_expected.to have_selector "#data_name"
  end

  it "submit btn is present" do
    is_expected.to have_selector "input[type='submit']"
  end
end
