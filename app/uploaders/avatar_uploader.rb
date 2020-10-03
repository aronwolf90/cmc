# frozen_string_literal: true

class AvatarUploader < BaseUploader
  include ActionView::Helpers::AssetUrlHelper
  include Webpacker::Helper

  def default_url(*_args)
    asset_path(Webpacker.manifest.lookup!("images/avatar_placeholder.png"))
  end
end
