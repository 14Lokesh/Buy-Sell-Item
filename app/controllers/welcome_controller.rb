# frozen_string_literal: true

# This is a sample class representing an  Welcome controller.
class WelcomeController < ApplicationController
  def search
    query = params.dig(:search_items, :query)
    city = params.dig(:search_items, :city)
    @items = query.present? ? Item.search(Item.search_items(query, city)) : []
    @items_with_photos = @items.map do |result|
      item = Item.find(result._id)
      if item.images.present?
        photo_urls = item.images.map { |image| url_for(image) }
        { item:, photo_urls: }
      end
    end.compact
  end
end
