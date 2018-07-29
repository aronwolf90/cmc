# frozen_string_literal: true

module Api::V1
  class FoldersController < ApiController
    include StandartActions

    def index
      super(Folder)
    end
  end
end
