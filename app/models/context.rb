# frozen_string_literal: trule

class Context < ActiveModelSerializers::Model
  include ActiveModel::Model
  attributes :current_user, :premium, :user_count

  delegate :id, to: :current_user, prefix: true
end
