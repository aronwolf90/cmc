# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdminArea::Organizations::Cell::Index, type: :cell do
  controller AdminArea::OrganizationsController

  subject do
    cell(described_class, model).().text
  end

  let(:model) { [organization] }
  let(:organization) { Organization.new(name: "Test") }

  it "show organization" do
    expect(subject).to include organization.to_s
  end
end
