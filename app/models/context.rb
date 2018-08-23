# frozen_string_literal: true

class Context < ActiveModelSerializers::Model
  include ActiveModel::Model
  attributes :current_user

  def current_user_id
    current_user.id
  end
end
