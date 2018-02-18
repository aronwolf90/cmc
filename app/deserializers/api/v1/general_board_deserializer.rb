# frozen_string_literal: true

module Api::V1
  class GeneralBoardDeserializer < ApiDeserializer
    map from("/relationships/board-lists/data"), to("/board_lists_attributes") do |board_lists|
      board_lists.map { |board_list| BoardListDeserializer.normalize(board_list).merge(id: board_list[:id]) }
    end
  end
end
