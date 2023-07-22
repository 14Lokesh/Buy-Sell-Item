# frozen_string_literal: true

# This is a sample class representing an  Message Model.
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :body, presence: true

  scope :unread_from_sender, ->(user) { where(read: false).where.not(sender_id: user.id) }
  scope :unread_received, ->(current_user) { where(read: false).where.not(sender_id: current_user.id) }
end
