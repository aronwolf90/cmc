# frozen_string_literal: true

module Api::V1
  class BoardListDeserializer < ApiDeserializer
    map from("/attributes/name"), to("/name")
    map from("/relationships/issues/data"), to("/issue_ids") do |issues|
      issues.map { |issue| issue[:id] }
    end
  end
end
