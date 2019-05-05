# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/attendances/index" do
  helper AdministrationHelper

  subject { rendered }

  before do
    Timecop.freeze("16.4.2019")
    sign_in(Admin.new)
    render
  end

  it "show user" do
    expect(subject).to have_css "attendances"
  end
end
