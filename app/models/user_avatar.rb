# frozen_string_literal: true

class UserAvatar < ApplicationRecord
  mount_uploader :file, AvatarUploader
end
