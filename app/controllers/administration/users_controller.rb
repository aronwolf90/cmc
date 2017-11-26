module Administration
  class UsersController < AdministrationController
    def index
      render inline: 'hi', layout: true
    end

    def show
      render inline: 'hi', layout: true
    end

    def new
      render inline: 'hi', layout: true
    end

    def edit
      render inline: 'hi', layout: true
    end

    def destroy
      render inline: 'hi', layout: true
    end
  end
end
