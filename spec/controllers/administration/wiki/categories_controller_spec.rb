# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Wiki::CategoriesController, type: :controller do

  let(:model) { WikiCategory.new(id: 1) }
  let(:form) { Administration::WikiCategoryForm }
  let(:params) { {} }

  include_examples "standard new action", Administration::WikiCategories
  include_examples "standard create action",
    Administration::WikiCategories, %i[administration wiki]
  include_examples "standard edit action", Administration::WikiCategories
  include_examples "standard update action", Administration::WikiCategories,
    %i[administration wiki]
  include_examples "standard destroy action", Administration::WikiCategories,
    %i[administration wiki]
end
