# frozen_string_literal: true

# This is a sample class representing an  Item controller.
class ItemsController < ApplicationController
  before_action :require_user_logged_in!, only: %i[product new]
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path, notice: 'Sent to admin for approval'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
  end

  def elastic_search
    query = params.dig(:search_items, :query)
    city = params.dig(:search_items, :city)
    @item = Item.search(Item.search_items(query.strip, city)).records
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :username, :phone, :city, :approved, :user_id,
                                 :approved_by_id, :category_id, images: [])
  end
end
