# frozen_string_literal: true

module ApplicationHelper
  module BtnHelper
    def new_btn(clazz, path, options = {})
      return unless policy(clazz).new?

      clazz_name = clazz.name
      link_to(
        "New #{clazz_name.downcase}",
        path,
        class: "btn btn-success #{options[:class]}"
      )
    end

    def edit_btn(object, path)
      return unless policy(object).edit?

      link_to '<i class="fa fa-edit"></i>'.html_safe, path,
              class: "btn btn-sm btn-secondary"
    end

    def csv_btn(object, path)
      return unless policy(object).index?

      link_to '<i class="fa fa-file-excel-o"></i>'.html_safe, path + ".csv",
              class: "btn btn-sm btn-success"
    end

    def destroy_btn(object, path, options = {})
      return unless policy(object).destroy?

      link_to "Destroy", path, method: :delete,
                               class: "btn btn-danger #{options[:class]}"
    end

    def cancel_btn(path = { action: :index }, options = {})
      link_to "Cancel", path, class: "btn btn-secondary #{options[:class]}"
    end

    def submit_btn(form)
      form.submit class: "btn btn-success"
    end
  end
end
