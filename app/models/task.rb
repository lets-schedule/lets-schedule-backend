class Task < ApplicationRecord
  belongs_to :user
  has_many :event
  has_one :constraint
end
