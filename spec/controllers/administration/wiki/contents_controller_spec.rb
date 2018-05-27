# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Wiki::ContentsController, type: :controller do
  before do
    cell_instance = Cell::ViewModel.new
    allow(Administration::WikiContent::Cell::Show).to receive(:call).and_return(cell_instance)
    allow(cell_instance).to receive(:call).and_return("")
    sign_in(build_stubbed(:user))
  end

  it "call wiki content cell" do
    expect(Administration::WikiContent::Cell::Show).to receive(:call)
    get :show
  end
end
