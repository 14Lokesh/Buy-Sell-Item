# frozen_string_literal: true

# This is a sample class representing an  Item controller.
class ItemsController < ApplicationController
  before_action :require_user_logged_in!, only: %i[index show new]
  before_action :restrict_admin, only: %i[new create]
  before_action :item, only: %i[index all_items]
  def index
    @items = Item.includes(:category, :user, images_attachments: :blob).approved_and_not_items_owner(current_user).page(params[:page]).per(6)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to items_path, flash: { notice: 'Sent to admin for approval' }
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @review = Review.new
    @reviews = @item.reviews.page(params[:page]).per(6)
  end

  def user_item
    @items = Item.includes(:category, :user).approved_by_user(current_user)
    @items = @items.page(params[:page]).per(6)
  end

  def user_pending_item
    @items = Item.includes(:category, :user).unapproved_by_user(current_user)
    @items = @items.page(params[:page]).per(6)
  end

  def elastic_search
    query = params.dig(:search_items, :query)
    data = params.dig(:search_items, :data)
    @item = Item.search(Item.search_items(query.strip, data)).records
    @items = @item.approved_items.page(params[:page]).per(6)
  end

  def all_items
    @items = Item.includes(:category, :user).approved_items.page(params[:page]).per(6)
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.user == current_user
      @item.destroy
      redirect_to user_item_path, flash: { notice: 'Item was successfully deleted.' }
    else
      redirect_to user_item_path, flash: { notice: 'You are not authorized to delete this item.' }
    end
  end

  private

  def item
    @item = Item.includes(:category, :user).all
  end

  def item_params
    params.require(:item).permit(:title, :description, :username, :phone, :city, :approved, :user_id,
                                 :approved_by_id, :category_id, images: [])
  end
end
