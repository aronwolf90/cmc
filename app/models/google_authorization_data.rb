# frozen_string_literal: true

require "dry-struct"

module Types
  include Dry::Types.module
end

class GoogleAuthorizationData < Dry::Struct
  attribute :access_token, Types::Strict::String.optional
  attribute :expires_at, Types::Strict::DateTime.optional
  attribute :refresh_token, Types::Strict::String.optional
end
