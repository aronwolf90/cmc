module Api::V1
  class RecordDeserializer < ApiDeserializer
    map from('/data/attributes/start_time'), to('/start_time')
    map from('/data/attributes/end_time'), to('/end_time')
    map from('/data/relationships/user/data/id'), to('/user_id')
    map from('/data/relationships/issue/data/id'), to('/issue_id')
  end
end
