class ArticlesController < ApplicationController
  inherit_resources
  before_filter :authenticate_admin_user!, except: [:index, :show]

  def create
    create! { admin_articles_path() }
  end

  def update
    update! { admin_articles_path() }
  end
end
