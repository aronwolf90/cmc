# frozen_string_literal: true

module Api
  module V1
    class GeneralBoardSerializer < ActiveModel::Serializer
      has_many :board_lists
    end
  end
end
