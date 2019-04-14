# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Wiki::PagesController, type: :controller do

  let(:model) { WikiPage.new(id: 1) }
  let(:form) { Administration::WikiPageForm }
  let(:params) { {} }

  include_examples "standard show action", Administration::WikiPages
  include_examples "standard new action", Administration::WikiPages
  include_examples "standard create action",
    Administration::WikiPages, %i[administration wiki]
end
