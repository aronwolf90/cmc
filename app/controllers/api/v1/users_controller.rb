# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    include StandartActions

    def index
      super(User)
    end

    def update
      super(operation: Users::UpdateOperation, model: user)
    end

  private

    def user
      @user ||= User.find(params[:id])
    end
  end
end
