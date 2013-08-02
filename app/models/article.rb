class Article < ActiveRecord::Base
  attr_accessible :body, :name, :tag, :content_html

  validates :body, :presence => true
end
