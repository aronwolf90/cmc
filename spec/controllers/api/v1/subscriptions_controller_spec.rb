# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::SubscriptionsController, type: :controller do
  let(:model) { Subscription.new(id: 1) }

  before { allow(Organization).to receive(:subscription).and_return(model) }

  include_examples "standard api show action"
end
