# frozen_string_literal: true

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  devise(
    :invitable,
    :database_authenticatable,
    :registerable,
    :invitable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
  )

  belongs_to :selected_project, class_name: "Project"

  has_many :issues
  has_many :records
  has_many :record_days, -> { ordered }
  has_one :current_record, -> { active.order(created_at: :desc) },
    class_name: "Record"
  has_many :users
  has_many :user_projects
  has_many :projects, through: :user_projects

  # Knock requires :authenticate
  alias_method :authenticate, :valid_password?

  def name
    [firstname, lastname].join(" ")
  end

  def to_s
    name
  end
end
