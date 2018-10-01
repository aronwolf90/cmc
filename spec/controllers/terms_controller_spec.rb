# frozen_string_literal: true

require "rails_helper"

RSpec.describe TermsController, type: :controller do
  describe "#show" do
    specify do
      get :show
      is_expected.to render_template(:show)
    end
  end
end
