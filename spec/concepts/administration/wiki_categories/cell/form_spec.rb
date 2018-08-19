# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::WikiCategories::Cell::Form, type: :cell do
  controller Administration::Wiki::CategoriesController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { build_stubbed(:admin) }
  let(:form) do
    Administration::WikiCategoryForm.new(WikiCategory.new)
  end

  it { is_expected.to have_selector("#data_title") }
  it { is_expected.to have_selector("#data_wiki_category_id") }
  it { is_expected.to have_selector("input[type='submit']") }
end
