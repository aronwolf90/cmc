# frozen_string_literal: true

require "rails_helper"

describe Administration::Calenders::Cell::Show, type: :cell do

  subject { described_class.().to_s }

  it { is_expected.to include "calender"  }
end
