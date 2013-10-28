class Role < ActiveRecord::Base
  has_many :users

  def geek?
    name.eql? "geek"
  end

  def normal?
    name.eql? "normal"
  end
end
