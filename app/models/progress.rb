class Progress < ApplicationRecord
  validates :content, presence: true
  belongs_to :post
  has_many :notifications, dependent: :destroy
  has_many :erais, dependent: :destroy
  has_many :sounandas, dependent: :destroy
  has_many :ouen2s, dependent: :destroy
  has_many :teinei2s, dependent: :destroy

  def has_erai?(user)
    self.erais.exists?(user_id: user.id)
  end

  def has_sounanda?(user)
    self.sounandas.exists?(user_id: user.id)
  end

  def has_ouen2?(user)
    self.ouen2s.exists?(user_id: user.id)
  end

  def has_teinei2?(user)
    self.teinei2s.exists?(user_id: user.id)
  end

  def create_notification_erai!(current_user)
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and progress_id = ? and action = ?', current_user.id, post.user_id, id, 'erai'])
    if tmp.blank?
      notification = current_user.active_notifications.new(
        progress_id: id,
        visited_id: post.user_id,
        action: 'erai'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_sounanda!(current_user)
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and progress_id = ? and action = ?', current_user.id, post.user_id, id, 'sounanda'])
    if tmp.blank?
      notification = current_user.active_notifications.new(
        progress_id: id,
        visited_id: post.user_id,
        action: 'sounanda'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_teinei2!(current_user)
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and progress_id = ? and action = ?', current_user.id, post.user_id, id, 'teinei2'])
    if tmp.blank?
      notification = current_user.active_notifications.new(
        progress_id: id,
        visited_id: post.user_id,
        action: 'teinei2'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_ouen2!(current_user)
    tmp = Notification.where(['visitor_id = ? and visited_id = ? and progress_id = ? and action = ?', current_user.id, post.user_id, id, 'ouen2'])
    if tmp.blank?
      notification = current_user.active_notifications.new(
        progress_id: id,
        visited_id: post.user_id,
        action: 'ouen2'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
