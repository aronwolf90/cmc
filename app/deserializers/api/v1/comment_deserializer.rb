module Api::V1
  class CommentDeserializer < ApiDeserializer
    map from("/data/attributes/content"), to("/content")
    map from("/data/relationships/user/data/id"), to("/user_id")
    map from("/data/relationships/issue/data/id"), to("/issue_id")
  end
end
