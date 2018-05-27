# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::Wiki::PagesController, type: :controller do
  let(:model) { build_stubbed(:wiki_page) }

  include_examples "standart show action", Administration::WikiPages
end
