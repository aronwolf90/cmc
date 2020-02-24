# frozen_string_literal: true

module ApplicationHelper
  module AssideHelper
    def asside_item(name, path:, policy:, **args)
      return unless policy

      clazz = "active" if request.url.ends_with?(url_for(path))

      content_tag(:li, class: clazz) do
        link_to path, **args do
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
end
