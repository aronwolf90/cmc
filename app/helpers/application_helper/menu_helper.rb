# frozen_string_literal: true

module ApplicationHelper
  module MenuHelper
    def menu_item(name, path:, policy:, includes:)
      return unless policy

      active = "active" if request.original_fullpath.include?(includes)
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
  end
end
