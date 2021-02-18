# frozen_string_literal: true

class SortMutation < ApplicationMutation
  attr_reader :collection, :model, :sort_key, :sort_value

  def initialize(collection, model:, sort_key:, sort_value: nil)
    @collection = collection
    @model = model
    @sort_key = sort_key
    @sort_value = sort_value
  end

  def call
    ActiveRecord::Base.transaction do
      next if sort_value.nil?
      next if model.nil?
      next if collection.nil?

      collection_to_order.each_with_index do |entry, index|
        entry.update!(sort_key => index)
      end

      collection_after_model.each_with_index do |entry, index|
        entry.update!(sort_key => index + sort_value + 1)
      end
    end
  end

private
  def sort_value
    @sort_value ||= model.public_send(sort_key)
  end

  def collection_to_order
    collection
      .where.not(id: model.id)
      .order(sort_key, created_at: :desc, id: :desc)
  end

  def collection_after_model
    collection_to_order
      .where("#{sort_key} >= ?", sort_value)
  end
end
