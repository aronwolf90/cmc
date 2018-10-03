# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Cell::Create, type: :cell do
  controller Administration::UsersController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { Admin.new }
  let(:form) { Administration::Users::CreateForm.new(User.new) }

  it { is_expected.to have_selector "#data_firstname" }
  it { is_expected.to have_selector "#data_lastname" }
  it { is_expected.to have_selector "#data_type" }
  it { is_expected.to have_selector "#data_password" }
  it { is_expected.to have_selector "#data_password_confirmation" }
  it { is_expected.to have_selector "input[type='submit']" }
  it { is_expected.to have_text "Cancel" }
end
