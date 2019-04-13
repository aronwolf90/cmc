# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/dashboards/show" do
  helper AdministrationHelper

  subject { rendered }

  before do
    sign_in(user)
    assign(:model, model)
    render
  end

  let(:user) { Admin.new(worked_issues: [worked_issue]) }
  let(:worked_issue) { Issue.new(id: 1, title: "worked issue") }
  let(:assigned_issue) { Issue.new(id: 2, title: "assigned issue") }
  let(:event) { build_stubbed(:event) }
  let(:model) {
    {
      projects: [ [project, 3600, 3600, 3600] ],
      worked_issues: Kaminari.paginate_array([worked_issue]).page(1).per(10),
      assigned_issues: Kaminari.paginate_array([assigned_issue]).page(1).per(10),
      events: Kaminari.paginate_array([event]).page(1).per(10)
    }
  }
  let(:project) { Project.new(id: 1, name: "Test") }

  before { Timecop.freeze("01.01.2018") }
  after { Timecop.return }

  it "project name is present" do
    is_expected.to have_text project.name
  end

  it "spended time at this month" do
    is_expected.to have_text "01:00:00"
  end

  it "worked issue is present" do
    is_expected.to have_text worked_issue.to_s
  end

  it "assigned issue is present" do
    is_expected.to have_text assigned_issue.to_s
  end

  it "event is present" do
    is_expected.to have_text event.to_s
  end
end