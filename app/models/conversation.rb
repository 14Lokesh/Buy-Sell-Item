# frozen_string_literal: true

# This is a sample class representing an  Conversation Model.
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  has_many :messages, dependent: :destroy

  def opposed_user(user)
    user == sender ? recipient : sender
  end

  def self.between(sender, recipients)
    where(sender: sender, recipient: recipients).or(where(sender: recipients, recipient: sender))
  end
end
