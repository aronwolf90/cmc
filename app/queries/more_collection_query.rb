# frozen_string_literal: true

class MoreCollectionQuery < ApplicationQuery
  class Result
    attr_reader :collection, :has_more

    def initialize(collection:, has_more:)
      @collection = collection
      @has_more = has_more
    end
  end

  attr_reader(
    :collection,
    :more_id,
    :sort_key,
    :per_page
  )

  def initialize(collection, more_id:, sort_key: :ordinal_number, per_page:, **)
    @collection = collection
    @more_id = more_id
    @sort_key = sort_key
    @per_page = per_page
  end

  def call
    if per_page.present?
      Result.new(
        collection: result_collection.limit(per_page),
        has_more: result_collection.count > per_page
      )
    else
      Result.new(
        collection: result_collection,
        has_more: false
      )
    end
  end

  private
    def result_collection
      if more_id.present?
        collection_by_more_id
      else
        collection
      end
    end

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
