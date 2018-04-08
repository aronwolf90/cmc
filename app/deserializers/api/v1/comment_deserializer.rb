# frozen_string_literal: true

module Api::V1
  class CommentDeserializer < ApiDeserializer
    map from("/attributes/content"), to("/content")
    map from("/relationships/user/data/id"), to("/user_id")
    map from("/relationships/issue/data/id"), to("/issue_id")
  end
end
