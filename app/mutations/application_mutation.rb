# frozen_string_literal: true

class ApplicationMutation
  attr_reader :model
  attr_private :attributes, :user

  def self.call(*args)
    new(*args).tap(&:call).model
  end

  def initialize(model:, user: nil, **attributes)
    @attributes = attributes.except(:current_user)
    @user = user
    @model = model
  end
end
