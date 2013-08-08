class ArticlesController < ApplicationController
  inherit_resources

  def create
    create! { articles_path }
  end
end
