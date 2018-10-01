# frozen_string_literal: true

module Api
  module V1
    module BoardLists
      class SortsController < ApiController
        include StandartActions
        namespace BoardLists::Sort

        public :update
      end
    end
  end
end
