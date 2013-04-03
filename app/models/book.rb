class Book < ActiveRecord::Base
  attr_accessible :body, :image_url, :title
end
