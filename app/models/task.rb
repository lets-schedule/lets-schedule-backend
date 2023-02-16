class Task < ApplicationRecord
  belongs_to :user
  has_many :events
  has_one :constraint

  validates :title, presence: true

  
end
