# frozen_string_literal: true

# This is a sample class representing an  Item controller.
class ItemsController < ApplicationController
  before_action :require_user_logged_in!, only: %i[show new]
  before_action :restrict_admin, only: %i[new create]
  def index
    @item = Item.all
    @item = Item.approved_and_not_items_owner(current_user).page(params[:page]).per(6)
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

  def product
    @item = Item.find(params[:id])
  end

  def user_item
    @user_items = Item.approved_by_user(current_user)
    @user_items = @user_items.page(params[:page]).per(6)
  end

  def user_pending_item
    @user_items = Item.unapproved_by_user(current_user)
    @user_items = @user_items.page(params[:page]).per(6)
  end

  def elastic_search
    query = params.dig(:search_items, :query)
    data = params.dig(:search_items, :data)
    @item = Item.search(Item.search_items(query.strip, data)).records
    @item = @item.approved_and_not_items_owner(current_user).page(params[:page]).per(6)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :username, :phone, :city, :approved, :user_id,
                                 :approved_by_id, :category_id, images: [])
  end
end
