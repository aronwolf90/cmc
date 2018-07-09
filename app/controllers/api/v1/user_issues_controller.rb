# frozen_string_literal: true

module Api::V1
  class UserIssuesController < ApiController
    include StandartActions

    def index
      render json: UserIssue.where(filter)
    end
  end
end
