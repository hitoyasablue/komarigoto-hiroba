class User < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
              format: {with: VALID_EMAIL_REGEX},
              uniqueness: {case_sensitive: true}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :wakarus, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
end
