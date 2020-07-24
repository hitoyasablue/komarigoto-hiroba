class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :wakarus, dependent: :destroy
  has_many :progresses, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def has_like?(user)
    self.likes.exists?(user_id: user.id)
  end

  def has_wakaru?(user)
    self.wakarus.exists?(user_id: user.id)
  end

  def create_notification_like!(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
