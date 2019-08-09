# frozen_string_literal: true

class ContactAvatar < ApplicationRecord
  mount_uploader :file, AvatarUploader
end
