# frozen_string_literal: true

class AvatarUploader < BaseUploader
  def default_url(*_args)
    ActionController::Base.helpers.asset_path("avatar_placeholder.png")
  end
end
