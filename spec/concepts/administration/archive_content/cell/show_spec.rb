# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::ArchiveContent::Cell::Show, type: :cell do
  controller Administration::Archive::ContentsController

  subject { cell(described_class, nil, current_user: user).() }

  let(:user) { Admin.new }

  it { is_expected.to have_link("add folder") }
  it { is_expected.to have_link("add document") }
  it { is_expected.to have_selector("archive-content") }
end
