# frozen_string_literal: true

class MvcFormGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  check_class_collision suffix: "Form"

  def create_form
    template(
      "form.rb.erb",
      File.join("app", "forms", class_path, "#{file_name}_form.rb")
    )
  end

  def create_spec
    template(
      "spec.rb.erb",
      File.join("spec", "forms", class_path, "#{file_name}_form_spec.rb")
    )
  end
end
