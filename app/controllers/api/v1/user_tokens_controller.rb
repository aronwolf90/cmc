# frozen_string_literal: true

require Rails.root.join("lib", "hacks", "knock_devise", "auth_token_controller").to_s

module Api::V1
  class UserTokensController < ::Knock::AuthTokenController
    include Hack::KnockDevise::AuthTokenController
  end
end
