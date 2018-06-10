# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Archive::ContentsController, type: :controller do
  before do
    cell_instance = Cell::ViewModel.new
    allow(Administration::ArchiveContent::Cell::Show).to receive(:call).and_return(cell_instance)
    allow(cell_instance).to receive(:call).and_return("")
    sign_in(build_stubbed(:user))
  end

  it "call archive content cell" do
    expect(Administration::ArchiveContent::Cell::Show).to receive(:call)
    get :show
  end
end
