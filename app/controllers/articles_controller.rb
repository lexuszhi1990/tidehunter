class ArticlesController < ApplicationController
  inherit_resources
  before_filter :authenticate_admin_user!, except: [:index, :show]

  def create
    create! { admin_article_path() }
  end

  def update
    update! { admin_article_path() }
  end
end
