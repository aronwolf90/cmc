# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::Cell::Index, type: :cell do
  controller Administration::ProjectsController

  subject { cell(described_class, model, current_user: current_user).() }

  let(:model) { [project1] }
  let(:project1) { build_stubbed(:project) }
  let(:current_user) { build_stubbed(:admin) }

  it "add new btn is present" do
    expect(subject.text).to include "New project"
  end

  it "project1 name is present" do
    expect(subject.text).to include "project title"
  end

  it "edit btn is present" do
    is_expected.to have_selector ".fa-edit"
  end
end
