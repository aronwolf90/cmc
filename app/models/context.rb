# frozen_string_literal: trule

class Context < ActiveModelSerializers::Model
  include ActiveModel::Model
  attributes :current_user

  def current_user_id
    current_user.id
  end
end
