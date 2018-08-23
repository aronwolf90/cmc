# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::DashboardsController, type: :controller do
  let(:model) { build_stubbed(:record) }
  let(:form) { Administration::RecordForm }
  let(:params) { {} }

  include_examples "standard show action", Administration::Dashboard
end
