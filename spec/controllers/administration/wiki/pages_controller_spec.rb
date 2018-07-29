# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::Wiki::PagesController, type: :controller do

  let(:model) { build_stubbed(:wiki_page) }
  let(:form) { Administration::WikiPageForm }
  let(:params) { {} }

  include_examples "standart show action", Administration::WikiPages
  include_examples "standart new action", Administration::WikiPages
  include_examples "standart create action",
    Administration::WikiPages, %i[administration wiki content]
end
