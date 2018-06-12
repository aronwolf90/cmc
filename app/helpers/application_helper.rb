# frozen_string_literal: true

module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def seconds_to_time(seconds)
    [seconds / 3600, seconds / 60 % 60, seconds % 60].map do |time|
      time.to_s.rjust(2, "0")
    end.join(":")
  end

  def l(object, options = {})
    super(object, options) if object
  end

  def standard_btn(name, link)
    link_to name, link, class: "btn btn-success"
  end
end
