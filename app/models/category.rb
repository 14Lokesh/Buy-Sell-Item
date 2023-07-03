# frozen_string_literal: true

# This is a sample class representing an  Category Model.
class Category < ApplicationRecord
  has_many :items
  validates :category, presence: true, length: { maximum: 20 }
end
