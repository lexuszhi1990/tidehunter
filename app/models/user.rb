class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password

  has_many :posts
  has_many :comments

  validates :name, :presence => true


end
