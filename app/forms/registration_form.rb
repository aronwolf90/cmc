# frozen_string_literal: true

require "reform/form/coercion"

class RegistrationForm < ApplicationForm
  model Registration

  property :name
  property :time_zone

  property :firstname
  property :lastname
  property :email
  property :password
  property :confirmation_password, virtual: true
  property :terms_service, virtual: true

  validates :name, presence: true
  validates :time_zone, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :confirmation_password, presence: true
  validates :terms_service, presence: true

  validate :same_password
  validate :password_length
  validate :uniq_organization_name

  def same_password
    return if confirmation_password == password

    errors.add(:password, "Password is diferent")
  end

  def password_length
    return if password.to_s.size >= 6

    errors.add(:password, "Password is too short")
  end

  def uniq_organization_name
    return unless Organization.exists?(name: name)

    errors.add(:password, "Organization is not uniq")
  end
end
