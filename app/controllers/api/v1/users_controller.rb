# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    include StandartActions
    namespace Users

    def index
      super(User)
    end

    def update
      super
    end

  private

    def model
      @model ||= User.find(params[:id])
    end
  end
end
