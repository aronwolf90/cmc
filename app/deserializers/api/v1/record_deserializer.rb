# frozen_string_literal: true

module Api::V1
  class RecordDeserializer < ApiDeserializer
    map from("/attributes/start-time"), to("/start_time")
    map from("/attributes/end-time"), to("/end_time")
    map from("/relationships/user/data/id"), to("/user_id")
    map from("/relationships/issue/data/id"), to("/issue_id")
  end
end
