# frozen_string_literal: true

# This is a sample class representing an Notification Model.
class Notification < ApplicationRecord
  belongs_to :user
  validates :message, presence: true
end
