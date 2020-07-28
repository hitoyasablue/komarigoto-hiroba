class Ouen2 < ApplicationRecord
  belongs_to :user
  belongs_to :progress
  validates :user_id, presence: true
  validates :progress_id, presence: true
end
