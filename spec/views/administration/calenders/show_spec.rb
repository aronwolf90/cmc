# frozen_string_literal: true

require "rails_helper"

describe "administration/calendars/show" do
  before do
    sign_in(Admin.new)
    render
  end

  it { is_expected.to include "calendar"  }
end
