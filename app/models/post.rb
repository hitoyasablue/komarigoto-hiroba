class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :progresses, dependent: :destroy

  def liked?(user)
    self.likes.exists?(user_id: user.id)
  end
end
