class Role < ActiveRecord::Base
  attr_accessible :name

  has_many :users

  def geek?
    name.eql? "geek"
  end

  def normal?
    name.eql? "normal"
  end
end
