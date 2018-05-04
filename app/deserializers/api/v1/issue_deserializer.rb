# frozen_string_literal: true

module Api::V1
  class IssueDeserializer < ApiDeserializer
    map from("/attributes/title"), to("/title")
    map from("/attributes/description"), to("/description")
    map from("/attributes/complexity"), to("/complexity")
    map from("/relationships/user/data/id"), to("/user_id")
  end
end
