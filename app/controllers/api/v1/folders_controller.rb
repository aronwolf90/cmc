# frozen_string_literal: true

module Api::V1
  class FoldersController < ApiController
    include StandartActions
    model_class Folder
    serializer FolderSerializer

    public :index
  end
end
