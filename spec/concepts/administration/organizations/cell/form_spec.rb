# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Organizations::Cell::Form, type: :cell do
  controller Administration::BoardListsController

  subject { cell(described_class, form, current_user: user).() }

  let(:user) { build_stubbed(:admin) }
  let(:form) do
    Administration::OrganizationForm.new(build_stubbed(:organization))
  end

  it { is_expected.to have_selector("#data_time_zone") }
end
