# frozen_string_literal: true

module Api::V1
  class UsersController < ApiController
    include StandartActions
    namespace Users
    model_class User

    public :index, :create, :update
  end
end
