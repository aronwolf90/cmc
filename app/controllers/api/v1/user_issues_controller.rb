# frozen_string_literal: true

module Api::V1
  class UserIssuesController < ApiController
    include StandartActions
    model_class UserIssue

    public :index
  end
end
