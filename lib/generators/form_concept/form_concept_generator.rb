# frozen_string_literal: true

class FormConceptGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  check_class_collision suffix: "Cell"

  def create_concept
    template(
      "concept.rb.erb",
      File.join("app", "concepts", class_path, file_name.pluralize, "cell", "form.rb")
    )
  end

  def create_views
    template(
      "view.slim",
      File.join("app", "concepts", class_path, file_name.pluralize, "views", "form.slim")
    )
  end

  def create_spec
    template(
      "spec.rb.erb",
      File.join("spec", "concepts", class_path, file_name.pluralize, "cell", "form_spec.rb")
    )
  end
end
