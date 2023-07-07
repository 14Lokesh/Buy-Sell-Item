# frozen_string_literal: true

# This is a sample class representing an  Item Model.
class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :title, length: { maximum: 30 }, presence: true
  validates :description, length: { maximum: 100 }, presence: true
  validates :phone, presence: true, numericality: { only_integer: true, message: 'must be a valid phone number' },
                    length: { is: 10, message: 'must be 10 digits' }
  validates :username, :city, presence: true
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.index_data
    __elasticsearch__.create_index! force: true
    __elasticsearch__.import
  end
  settings index: {number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :title, type: :text
      indexes :city, type: :text
      indexes :description, type: :text
      indexes :approved, type: :boolean
      indexes :username, type: :text
      indexes :category, type: :text
    end
  end

  def as_indexed_json(_options = {})
    {
      id: id,
      title: title,
      city: city,
      description: description,
      approved: approved,
      username: username,
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
        query_string: {
            query: "*#{query}*",
            fields: %i[title  category ]
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
  index_data
end
