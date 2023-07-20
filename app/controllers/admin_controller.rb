# frozen_string_literal: true

# This is a sample class representing an Admin controller.
class AdminController < ApplicationController
  before_action :check_admin
  def new
    @item = Item.new
  end

  def index
    @fetched_data = Item.all
  end

  def approved
    @item = Item.find(params[:id])
    @admin = current_admin
    @item.approved_by_id = @admin.id
    @item.approved = true
    @item.save
    redirect_to items_path, flash: { notice: 'Approved Successfully' }
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path, flash: { notice: 'Deleted successfully' }
  end

  def admin; end
end
