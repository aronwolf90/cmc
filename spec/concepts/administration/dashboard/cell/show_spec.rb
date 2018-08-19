# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Dashboard::Cell::Show, type: :cell do
  controller Administration::DashboardsController

  subject { cell(described_class, model, current_user: user).() }

  let(:user) { build_stubbed(:admin) }
  let(:model) { { projects: { project => 3600 } } }
  let(:project) { build_stubbed(:project) }

  before { Timecop.freeze("01.01.2018") }
  after { Timecop.return }

  it "project name is present" do
    is_expected.to have_text project.name
  end

  it "spended time at this month" do
    is_expected.to have_text "01:00:00"
  end

  it "personal_dashboard_graph is present" do
    is_expected.to have_selector "personal_dashboard_graph"
  end
end
