module Administration
  class ProjectsController < AdministrationController
    side_menu 'administration/projects'

    def index
      run Project::Index

      render cell(Project::Cell::Index, result['model'])
    end

    def show
      run Project::Show

      render cell(Project::Cell::Show)
    end
  end
end
