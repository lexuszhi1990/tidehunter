class Article < ActiveRecord::Base
  attr_accessible :body, :name, :tag

  validates :body, :presence => true
end
