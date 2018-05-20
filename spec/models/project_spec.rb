# frozen_string_literal: true

require "rails_helper"

RSpec.describe Project, type: :model do
  it { is_expected.to have_many :board_lists }
  it { is_expected.to have_many :issues }
  it { is_expected.to have_many :records }
end
