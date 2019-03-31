# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin_area/organizations/index.slim" do
  subject do
    assign(:model, model)
    render
    rendered
  end

  let(:model) { [organization] }
  let(:organization) { Organization.new(name: "Test") }

  it "show organization" do
    expect(subject).to have_content organization.to_s
  end
end
