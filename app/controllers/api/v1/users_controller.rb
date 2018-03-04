# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    def index
      render json: User.all, include: :current_record
    end
  end
end
