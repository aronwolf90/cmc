# frozen_string_literal: true

module ApplicationHelper
  module MenuHelper
    def menu_item(name, path:, policy:, includes:)
      return unless policy

      content_tag(:li, class: "nav-item") do
        content_tag(:'menu-item', nil, path: path, name: name, 'starts-with': "/administration/#{includes}")
      end
    end

    def menu_logo(logo, path)
      content_tag :"router-link", to: path do
        image_pack_tag logo, id: "logo", height: 21, width: 40
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
