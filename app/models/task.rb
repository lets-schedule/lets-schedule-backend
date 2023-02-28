class Task < ApplicationRecord

  belongs_to :user

  has_many :events, dependent: :destroy
  has_one :constraint, dependent: :destroy


  validates :title, presence: true


end
