# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::Wiki::CategoriesController, type: :controller do

  let(:model) { build_stubbed(:wiki_page) }
  let(:form) { Administration::WikiPageForm }
  let(:params) { {} }

  include_examples "standart new action", Administration::WikiCategories
  include_examples "standart create action",
    Administration::WikiCategories, %i[administration wiki content]
  include_examples "standart edit action", Administration::WikiCategories
  include_examples "standart update action", Administration::WikiCategories,
    %i[administration wiki content]
  include_examples "standart destroy action", Administration::WikiCategories,
    %i[administration wiki content]
end
