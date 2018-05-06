# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Projects::Cell::Form, type: :cell do
  controller Administration::ProjectsController

  let(:form) { Administration::ProjectForm.new(project) }
  let(:project) { build_stubbed(:project) }

  it "add new btn is present" do
    expect(cell(described_class, form).()).to have_selector "#data_name"
  end

  it "submit btn is present" do
    expect(cell(described_class, form).()).to have_selector "input[type='submit']"
  end
end
