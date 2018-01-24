class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise :invitable, :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :issues

  def name
    [firstname, lastname].join(' ')
  end

  def to_s
    name
  end
end
