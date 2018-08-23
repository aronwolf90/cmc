# frozen_string_literal: true

class Registration
  include ActiveModel::Model

  attr_accessor(
    :name,
    :time_zone,
    :firstname,
    :lastname,
    :email,
    :password
  )
end
