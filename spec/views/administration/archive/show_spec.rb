# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/archive/show" do
  helper AdministrationHelper

  subject { rendered }

  before do
    sign_in(Admin.new)
    allow(view).to receive(:new_btn).with([:archive, Folder])
    allow(view).to receive(:new_btn).with([:archive, Document])
    render
  end

  it "render new folder btn" do
    expect(view).to have_received(:new_btn).with([:archive, Folder])
  end

  it "render new document btn" do
    expect(view).to have_received(:new_btn).with([:archive, Document])
  end

  it { is_expected.to have_selector("archive-content") }
end
