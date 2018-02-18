# frozen_string_literal: true

class GeneralBoard < ActiveModelSerializers::Model
  def board_lists
    @board_lists ||= BoardList.all.order(:ordinal_number)
  end

  def board_lists_attributes=(board_lists)
    @board_lists = board_lists.map do |attributes|
      board_list = BoardList.find(attributes[:id])
      board_list.assign_attributes(attributes)
      board_list
    end
  end

  def update!
    ActiveRecord::Base.transaction do
      board_lists.each_with_index do |board_list, index|
        board_list.update!(ordinal_number: index)
      end
    end
  end

  def self.update!(attributes)
    new(attributes).update!
  end
end
