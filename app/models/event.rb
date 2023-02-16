class Event < ApplicationRecord
  belongs_to :task

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true
end
