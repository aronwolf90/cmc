# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserProject, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:project) }
end
