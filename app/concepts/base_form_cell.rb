# frozen_string_literal: true

class BaseFormCell < ApplicationCell
private
  def actions(form:, destroy_path: nil, cancell_path: nil)
    capture do
      concat success_btn(form)
      concat(content_tag(:div, class: "btn-group pull-right") do
        if destroy_path && model.model.persisted?
          concat destroy_btn(destroy_path)
        end
        concat cancell_btn(cancell_path) if cancell_path
      end)
    end
  end

  def success_btn(form)
    form.submit class: "btn btn-success"
  end

  def destroy_btn(path_array, policy: path_array.last, **options)
    return unless policy(policy).destroy?

    options[:class] = options[:class].to_s + " btn btn-danger"
    options[:method] ||= :delete

    link_to "Destroy", path_array, options
  end

  def cancell_btn(path)
    link_to "Cancel", path,
      class: "btn btn-secondary"
  end
end
