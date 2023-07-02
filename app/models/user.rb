class User < ApplicationRecord
    has_secure_password
    has_many :items
    has_many :notifications
    has_many :reviews
    has_many :sent_conversations, class_name: 'Conversation', foreign_key: 'sender_id'
    has_many :received_conversations, class_name: 'Conversation', foreign_key: 'recipient_id'
    validates :username, :email , :password_digest , presence: true
end
