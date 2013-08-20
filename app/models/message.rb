class Message < ActiveRecord::Base
  attr_accessible :state

  validates :state, presence: true

  scope :recent, order("created_at DESC")
end
