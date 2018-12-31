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

  def menu_item(name, path:, policy:, includes:)
    return unless policy

    active = "active" if request.url.include?(includes)
    content_tag(:li, class: "nav-item #{active}") do
      link_to name, path, class: "nav-link small"
    end
  end

  def menu_logo(logo, path)
    link_to path do
      image_tag logo, id: "logo", height: 21, width: 40
    end
  end

  def left_menu
    content_tag :ul, class: "navbar-nav mr-auto ml-4" do
      yield
    end
  end

  def menu
    content_tag :nav, class: "navbar navbar-expand-sm navbar-dark fixed-top" do
      yield
    end
  end

  def right_menu
    content_tag :ul, class: "navbar-nav" do
      yield
    end
  end

  def user_menu_dropdown_text
    content_tag :a, class: "dropdown-toggle", "data-toggle": "dropdown", aria: { haspopup: "true", expanded: "false" } do
      yield
    end
  end

  def user_menu_dropdown_body
    content_tag :div, class: "dropdown-menu dropdown-menu-right" do
      yield
    end
  end

  def dropdown_link(*args, **options, &block)
    options[:class] ||= ""
    options[:class] += " dropdown-item"
    link_to *args, options, &block
  end
end
