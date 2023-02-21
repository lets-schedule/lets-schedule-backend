class Event < ApplicationRecord
  belongs_to :task

  validates :startTime, presence: true
  validates :endTime, presence: true
end
