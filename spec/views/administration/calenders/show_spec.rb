# frozen_string_literal: true

require "rails_helper"

describe "administration/calenders/show" do
  before do
    sign_in(Admin.new)
    render
  end

  it { is_expected.to include "calender"  }
end
