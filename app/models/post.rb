class Post < ActiveRecord::Base
  attr_accessible :body, :title, :tag
  
  belongs_to :user
  has_many :comments

  validates :body, :presence => true
  validates :title, :presence => true
  validates :tag, :presence => true

end