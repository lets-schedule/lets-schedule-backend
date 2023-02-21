class Task < ApplicationRecord

  belongs_to :user

  has_many :events, dependent: :destroy


end
