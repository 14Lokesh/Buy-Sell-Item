# frozen_string_literal: true

# This is a sample class representing an Admin controller.
class AdminController < ApplicationController
  before_action :check_admin
  def index; end

  def new
    @item = Item.new
  end

  def approved
    @item = Item.find(params[:id])
    @admin = current_admin
    @item.approved_by_id = @admin.id
    @item.approved = true
    @item.save
    redirect_to items_path, flash: { notice: ' Item Approved Successfully' }
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to approval_page_admin_index_path, flash: { notice: 'Item Deleted successfully' }
  end

  def approval_page
    @items = Item.page(params[:page]).where(approved: false).per(6)
  end
end
