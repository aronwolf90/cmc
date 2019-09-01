# frozen_string_literal: true

module Api
  module V1
    class DocumentsController < ApiController
      include StandartActions
      namespace ::Api::V1::Documents
      model_class Document

      public :index, :show, :create, :update, :destroy
    end
  end
end
