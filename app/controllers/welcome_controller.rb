# frozen_string_literal: true
class WelcomeController < ApplicationController
    # def index
    # end

    def search
        query = params.dig(:search_items, :query)
        city = params.dig(:search_items, :city)
      
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
        
        if city.present?
          search_definition[:query][:bool][:filter] ||= []
          search_definition[:query][:bool][:filter] << {
            term: {
              city: city
            }
          }
        end
        
        search_definition[:query][:bool][:filter] ||= []
        search_definition[:query][:bool][:filter] << {
          term: {
            approved: true
          }
        }
        
        @items = query.present? ? Item.search(search_definition) : []

        @items_with_photos = @items.map do |result|
          item = Item.find(result._id)
          if item.images.present?
            photo_urls = item.images.map { |image| url_for(image) }
            { item: item, photo_urls: photo_urls }
          end
        end.compact
        
    
      
      end
        
end
