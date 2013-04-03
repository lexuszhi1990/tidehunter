class Travel < ActiveRecord::Base
  attr_accessible :body, :place, :when, :image_url
end
