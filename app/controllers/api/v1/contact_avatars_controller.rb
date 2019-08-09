# frozen_string_literal: true

module Api
  module V1
    class ContactAvatarsController < ApiController
      include StandartActions
      namespace ::Api::V1::ContactAvatars

      public :create
    end
  end
end
