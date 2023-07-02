# frozen_string_literal: true
class AdminController < ApplicationController
    before_action :check_admin
    def index
        @item = Item.all
        @notifications = current_user.notifications.order(created_at: :desc)

    end
    def new
        @item = Item.new
    end

    def approved_posts
        @fetched_data = Item.all
    end

     def approved
        @item = Item.find(params[:id])
        @admin = current_admin
        @item.approved_by_id= @admin.id
        @item.approved = true
        @item.save
        redirect_to root_path , notice: "Approved Successfully"
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to root_path,notice: "Deleted successfully"
    end

end
