class Post < ActiveRecord::Base
  attr_accessible :body, :title, :url
  
  belongs_to :user
  has_many :comments

  validates :body, :presence => true
  validates :title, :presence => true
  validates :url, :presence => true

end
