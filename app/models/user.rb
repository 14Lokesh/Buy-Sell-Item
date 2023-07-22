# frozen_string_literal: true

# This is a sample class representing an User Model.
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  before_save { self.username = username.titleize }
  has_secure_password

  has_many :items, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'recipient_id'

  validates :username, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX, message: 'must be a valid email address' },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
end
