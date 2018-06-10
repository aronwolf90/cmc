# frozen_string_literal: true

module Api::V1
  class FoldersController < ApiController
    def index
      render json: Folder.all, include: :documents
    end
  end
end
