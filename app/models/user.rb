class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_s
    [firstname, lastname].join(' ')
  end
end
