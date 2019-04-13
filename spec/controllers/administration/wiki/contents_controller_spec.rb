# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Wiki::ContentsController, type: :controller do
  before do
    sign_in(build_stubbed(:user))
  end

  it "call wiki content cell" do
    get :show
    is_expected.to render_template(:show)
  end
end
