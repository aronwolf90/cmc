# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Users::RecordsController, type: :controller do
  let(:params) { { user_id: 1 } }
  let(:user) { Admin.new(id: 1) }

  before { allow(User).to receive(:find).and_return(user) }

  include_examples "standard index action", Administration::Users::Records
end
