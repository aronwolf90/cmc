# frozen_string_literal: true

require "rails_helper"

RSpec.describe "administration/users/index" do
  helper AdministrationHelper

  subject { rendered }

  let(:model) { [user1] }
  let(:user1) { build_stubbed(:user) }
  let(:user) { build_stubbed(:admin)  }

  it { is_expected.to have_text "New user" }
  it { is_expected.to have_text user1 }
  it { is_expected.to have_selector "[href='/administration/users/#{user1.id}/edit']" }

  before do
    sign_in(user)
    assign(:model, model)
    render
  end

  context "user is an customer" do
    let(:user) { build_stubbed(:customer) }

    it { is_expected.not_to have_selector "[href='/administration/users/#{user1.id}/edit']" }
  end
end
