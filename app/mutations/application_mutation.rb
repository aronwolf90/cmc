# frozen_string_literal: true

class ApplicationMutation
  attr_reader :model
  attr_private :attributes, :user

  def self.call(*args)
    retried ||= false
    Rails.logger.debug [self, args]
    new(*args).tap(&:call).model
  rescue ActiveRecord::PreparedStatementCacheExpired
    if retried
      raise
    else
      retried = true
      retry
    end
  end

  def initialize(model:, user: nil, **attributes)
    @attributes = attributes.except(:current_user).with_indifferent_access
    @user = user
    @model = model
  end
end
