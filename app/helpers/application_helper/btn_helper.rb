# frozen_string_literal: true

module ApplicationHelper
  module BtnHelper
    def new_btn(clazz, path)
      return unless policy(clazz).new?

      clazz_name = clazz.name
      link_to(
        "New #{clazz_name.downcase}",
        path,
        class: "btn btn-success btn-block"
      )
    end

    def edit_btn(object, path)
      return unless policy(object).edit?

      link_to fa_icon(:edit), path,
        class: "btn btn-sm btn-secondary"
    end

    def csv_btn(object, path)
      return unless policy(object).index?

      link_to fa_icon(:"file-excel-o"), path,
        class: "btn btn-sm btn-success"
    end
  end
end
