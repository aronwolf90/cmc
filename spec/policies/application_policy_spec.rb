
# frozen_string_literal: true

require "rails_helper"

describe ApplicationPolicy::Scope do
  specify do
    expect(described_class.new(User.new, User.all).())
      .to eq User.all
  end
end
