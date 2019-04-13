# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/wiki/categories/form" do
  helper AdministrationHelper

  subject { rendered }

  let(:user) { Admin.new }
  let(:form) do
    Administration::WikiCategoryForm.new(WikiCategory.new)
  end

  before do
    sign_in(Admin.new)
    assign :model, form
    render
  end

  it { is_expected.to have_selector("#data_title") }
  it { is_expected.to have_selector("#data_wiki_category_id") }
  it { is_expected.to have_selector("input[type='submit']") }
end
