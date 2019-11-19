# frozen_string_literal: true

class ApplicationApi < ActiveModelSerializers::Model
  include ActiveModel::Model

  def self.create(attributes)
    new(attributes).tap(&:create)
  end

  def self.create_or_update(attributes)
    new(attributes).tap(&:create_or_update)
  end

  def ==(object)
    attributes == object.attributes
  end

  def create_or_update
    if id.present?
      update
    else
      create
    end
  end
end
