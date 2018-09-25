# frozen_string_literal: true

class Module
  def application_descendant?
    return false if instance_of?(Module)
    return false unless self < Object
    return false if self == ApplicationRecord
    return false if self == ActiveRecord::Base
    true
  end
end

class String
  def try_constanize
    constantize
  rescue NameError
    nil
  end

  def to_domain
    domain = underscore.
      tr("_", "-").
      tr(" ", "-").
      gsub(/[^0-9a-z\-]/i, "")

    domain = "a#{domain}" if domain.first == "-"
    domain = "#{domain}e" if domain.last  == "-"

    domain
  end
end
