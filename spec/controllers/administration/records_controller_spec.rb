# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::RecordsController, type: :controller do
  let(:model) { build_stubbed(:record) }
  let(:form) { Administration::RecordForm }
  let(:params) { {} }

  include_examples "standard index action", Administration::Records
  include_examples "standard new action", Administration::Records
  include_examples "standard edit action", Administration::Records
  include_examples "standard create action", Administration::Records, %i[administration records]
  include_examples "standard update action", Administration::Records, %i[administration records]
  include_examples "standard destroy action", Administration::Records, %i[administration records]
end
