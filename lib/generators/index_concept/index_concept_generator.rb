# frozen_string_literal: true

class IndexConceptGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  check_class_collision suffix: "Cell"

  def create_concept
    template(
      "concept.rb.erb",
      File.join("app", "concepts", class_path, file_name.pluralize, "cell", "index.rb")
    )
  end

  def create_views
    template(
      "view.slim",
      File.join("app", "concepts", class_path, file_name.pluralize, "views", "index.slim")
    )
  end

  def create_spec
    template(
      "spec.rb.erb",
      File.join("spec", "concepts", class_path, file_name.pluralize, "cell", "index_spec.rb")
    )
  end
end
