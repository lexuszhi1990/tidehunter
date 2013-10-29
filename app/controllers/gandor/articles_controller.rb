class Gandor::ArticlesController < Gandor::ApplicationController

  private
    def permitted_params
      params.permit(:article => [:name, :body])
    end
end
