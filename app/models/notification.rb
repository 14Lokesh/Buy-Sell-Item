# frozen_string_literal: true

# This is a sample class representing an Notification Model.
class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  def self.mark_as_read(user)
    where(read: false, user_id: user).update_all(read: true)
  end
end
