# frozen_string_literal: true

class JsonApiQuery < ApplicationQuery
  attr_reader(
    :relation,
    :sort_options,
    :include_options,
    :filter_params,
    :query
  )

  def initialize(relation, sort: [], include: [], filter: {}, query: nil, **)
    @relation = relation
    @sort_options = sort
    @include_options = include.is_a?(Array) ? include.join(",") : include.to_s
    @filter_params = filter
    @query = query
  end

  def call
    collection =
      relation
      .where(filter_options)
      .order(sort_options)
      .ordered
      .includes(DotStrings::HashConverter.call(include_options.split(",")))

    if query.present?
      collection.search(query)
    else
      collection
    end
  end

  private
    def filter_options
      filter_params.map do |key, value|
        if value == "null"
          [key, nil]
        elsif !value.to_s.to_range.nil?
          [key, value.to_range]
        else
          [key, value]
        end
      end.to_h
    end
end
