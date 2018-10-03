# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Cell::Update, type: :cell do
  controller Administration::UsersController

  subject { cell(described_class, form, current_user: user).() }

  let(:form) { Administration::Users::UpdateForm.new(user) }
  let(:user) { build_stubbed(:user) }

  it { is_expected.to have_selector "#data_firstname" }
  it { is_expected.to have_selector "#data_lastname" }
  it { is_expected.to have_selector "#data_telephone_number" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
