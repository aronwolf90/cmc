# frozen_string_literal: true

module BoardLists
  class SortStep < ApplicationStep
    def self.call(options, params:, **args)
      params[:data].each_with_index do |board_list_id, index|
        BoardList.find(board_list_id).update!(ordinal_number: index)
      end
    end
  end
end
