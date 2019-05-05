# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::AttendancesController, type: :controller do
  let(:params) { {} }

  it "GET index" do
    sign_in Admin.new
    expect(get :index).to render_template :index
  end
end
