class Message < ActiveRecord::Base
  validates :state, presence: true

  scope :recent, order("created_at DESC")
end
