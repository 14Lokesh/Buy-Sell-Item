# frozen_string_literal: true

# This is a sample class representing an  Item Model.
class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :title, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }
  validates :phone, presence: true, numericality: { only_integer: true, message: "must be a valid phone number" },
                                                 length: { is: 10, message: "must be 10 digits" } 
  validates :username, :city, presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: :english
      indexes :city, type: :text, analyzer: :english
      indexes :description, type: :text, analyzer: :english
      indexes :approved, type: :boolean, analyzer: :english
      indexes :username, type: :text, analyzer: :english
      indexes :category, type: :keyword
    end
  end

  def as_indexed_json(_options = {})
    {
      id:,
      title:,
      city:,
      description:,
      approved:,
      username:,
      category: category.category
    }
  end

  def self.search_items(query, cities)
    search_definition = {
      query: {
        bool: {
          must: []
        }
      }
    }

    if query.present?
      search_definition[:query][:bool][:must] << {
        wildcard: {
          title: {
            value: "*#{query}*"
          }
        }
      }
    end

    if cities.present?
      search_definition[:query][:bool][:filter] ||= []
      search_definition[:query][:bool][:filter] << {
        term: {
          city: cities
        }
      }
    end

    search_definition[:query][:bool][:filter] ||= []
    search_definition[:query][:bool][:filter] << {
      term: {
        approved: true
      }
    }

    search_definition
  end

  def approve!(admin)
    self.approved_by_id = admin.id
    self.approved = true
    save
  end
end
