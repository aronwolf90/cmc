# frozen_string_literal: true

class JsonApiQuery < ApplicationQuery
  attr_reader :relation, :sort_options, :include_options, :filter_params

  def initialize(relation, sort: [], include: [], filter: {}, **_args)
    @relation = relation
    @sort_options = sort
    @include_options = include
    @filter_params = filter
  end

  def call
    relation
      .where(filter_options)
      .order(sort_options)
      .includes(include_options)
  end

private

  def filter_options
    filter_params.map do |key, value|
      [key, value != "null" ? value : nil]
    end.to_h
  end
end
