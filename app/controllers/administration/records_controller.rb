module Administration
  class RecordsController < AdministrationController
    def index
      render inline: 'hi', layout: true
    end

    def new
      render inline: 'hi', layout: true
    end

    def create
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
