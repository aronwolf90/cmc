# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Cell::Index, type: :cell do
  controller Administration::UsersController

  subject { cell(described_class, model).() }

  let(:model) { [user1] }
  let(:user1) { build_stubbed(:user) }

  it { is_expected.to have_text "New user" }
  it { is_expected.to have_text user1 }
  it { is_expected.to have_selector ".fa-edit" }
end
