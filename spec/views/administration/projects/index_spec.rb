# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/projects/index.slim" do
  helper AdministrationHelper

  subject { rendered }

  let(:model) { [project] }
  let(:project) { build_stubbed(:project) }

  before do
    sign_in(Admin.new)
    assign(:model, model)
    allow(view).to receive :new_btn
    allow(view).to receive :edit_btn
    render
  end

  it "render the new btn" do
    expect(view).to have_received :new_btn
  end

  it "render the edit btn" do
    expect(view).to have_received :edit_btn
    subject
  end

  it "render the project"  do
    expect(subject).to have_content project.to_s
  end
end
