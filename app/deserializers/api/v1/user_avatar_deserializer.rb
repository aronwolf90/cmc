# frozen_string_literal: true

module Api::V1
  class UserAvatarDeserializer
    def self.call(params)
      { file: params[:file] }
    end
  end
end
