# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Dashboard::Cell::Show, type: :cell do
  controller Administration::DashboardsController

  subject { cell(described_class, model).().text }

  let(:model) { { projects: { project => 3600 } } }
  let(:project) { build_stubbed(:project) }

  before { Timecop.freeze("01.01.2018") }
  after { Timecop.return }

  it "project name is present" do
    expect(subject).to include(project.name)
  end

  it "spended time at this month" do
    expect(subject).to include("01:00:00")
  end
end
