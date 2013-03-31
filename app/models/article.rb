class Article < ActiveRecord::Base
  attr_accessible :body, :name, :tag
end
