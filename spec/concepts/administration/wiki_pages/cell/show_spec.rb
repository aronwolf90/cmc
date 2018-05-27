# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::WikiPages::Cell::Show, type: :cell do
  controller Administration::RecordsController

  subject { cell(described_class, build_stubbed(:wiki_page)).() }


  it { is_expected.to have_selector("wiki-page") }
end
