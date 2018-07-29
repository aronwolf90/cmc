# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Administration::RecordsController, type: :controller do
  let(:model) { build_stubbed(:record) }
  let(:form) { Administration::RecordForm }
  let(:params) { {} }

  include_examples "standart index action", Administration::Records
  include_examples "standart new action", Administration::Records
  include_examples "standart edit action", Administration::Records
  include_examples "standart create action", Administration::Records, %i[administration records]
  include_examples "standart update action", Administration::Records, %i[administration records]
  include_examples "standart destroy action", Administration::Records, %i[administration records]
end
