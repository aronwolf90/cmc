# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::UsersController, type: :controller do
  let(:model) { User.new(id: 1) }
  let(:form) { Administration::Users::CreateForm }
  let(:params) { {} }

  before do
    allow(Organization)
      .to receive(:current)
      .and_return(Organization.new(time_zone: "Berlin"))
  end

  include_examples "standard index action", Administration::Users
  include_examples "standard new action",
                   Administration::Users
  include_examples "standard update action", Administration::Users,
                   [:administration, :user, id: 1]
end
