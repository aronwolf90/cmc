# frozen_string_literal: true

class MoreCollectionQuery < ApplicationQuery
  attr_reader(
    :collection,
    :more_id,
    :sort_key
  )

  def initialize(collection, more_id:, sort_key: :ordinal_number, **)
    @collection = collection
    @more_id = more_id
    @sort_key = sort_key
  end

  def call
    if more_id.present?
      collection_by_more_id
    else
      collection
    end
  end

private

  def collection_by_more_id
    if sort_attribute.present?
      collection
        .where("#{sort_key} > ? ", sort_attribute)
    else
      collection
        .where("created_at < ? ", more_id_entry.created_at)
    end
  end

  def sort_attribute
    more_id_entry.public_send(sort_key)
  end

  def more_id_entry
    collection.find(more_id)
  end
end
