# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model,
      **attributes
    )
  end

  let(:current_user) { create(:admin) }
  let(:model) { Notification.new }
  let(:attributes) { { user_id: current_user.id } }

  specify do
    expect { subject }.to change(Notification, :count).by(1)
  end
end
