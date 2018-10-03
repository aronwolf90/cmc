# frozen_string_literal: true

class ApplicationMutation
  attr_private :model, :attributes, :user

  def self.call(*args)
    new(*args).call
  end

  def initialize(model:, user: nil, **attributes)
    @attributes = attributes.except(:current_user)
    @user = user
    @model = model
  end
end
