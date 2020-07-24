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
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
    if tmp.blank?
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

  def create_notification_wakaru!(current_user)
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'wakaru'])
    if tmp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'wakaru'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
