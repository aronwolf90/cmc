# frozen_string_literal: true

require "uri"

module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-warn"
    end
  end

  def seconds_to_time(seconds)
    [seconds / 3600, seconds / 60 % 60, seconds % 60].map do |time|
      time.to_i.to_s.rjust(2, "0")
    end.join(":")
  end

  def standard_btn(name, link)
    link_to name, link, class: "btn btn-success"
  end

  def organization_sign_in_url(organization)
    request.protocol + [
      organization.name,
      "#{request.host_with_port}/users/sign_in"
    ].join(".")
  end

  def asside_item(name, path:, policy:)
    return unless policy

    clazz = "active" if request.url.ends_with?(url_for(path))

    content_tag(:li, class: clazz) do
      link_to path do
        name.to_s.camelize
      end
    end
  end

  def top_asside_item(name, icon:, path:)
    content_tag(:li) do
      link_to path do
        concat fa_icon(icon, class: "fa-lg")
        concat "&nbsp &nbsp #{name}".html_safe
      end
    end
  end

  def asside(policy)
    return unless policy

    content_tag(:div, class: "side-menu") do
      content_tag(:ul, class: "nav navbar-nav") do
        yield
      end
    end
  end
end
