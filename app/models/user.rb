class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role

  after_create :set_default_role


  def geek?
    role.geek?
  end

  def role_name
    role.name
  end

  def add_role(role)
    self.role = Role.find_by_name(role)
  end

  private
    def set_default_role
      add_role "normal"
    end
end
