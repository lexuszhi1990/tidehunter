class Gandor::ArticlesController < Gandor::ApplicationController

  private
    def build_resource_params
      [params.require(:article).permit(:name, :body)]
    end
end
