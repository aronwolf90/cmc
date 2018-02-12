# frozen_string_literal: true

module Api::V1
  class CurrentRecordsController < ApiController
    def show
      render json: user.current_record
    end

  private

    def user
      @user ||= User.find(params[:user_id])
    end
  end
end
