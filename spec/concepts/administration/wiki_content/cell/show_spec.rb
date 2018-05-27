# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::WikiContent::Cell::Show, type: :cell do
  controller Administration::RecordsController

  subject { cell(described_class).() }

  it { is_expected.to have_link("add category") }
  it { is_expected.to have_link("add page") }
  it { is_expected.to have_selector("wiki-content") }
end
