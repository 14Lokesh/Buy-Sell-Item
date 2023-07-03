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
    @item.approve!(@admin)
    redirect_to root_path, notice: 'Approved Successfully'
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path, notice: 'Deleted successfully'
  end
end
