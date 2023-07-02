# frozen_string_literal: true
class CategoriesController < ApplicationController
    before_action :require_user_logged_in!
    before_action :check_admin

    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
           redirect_to root_path
        else
            render :new
        end
    end

    private
    def category_params
        params.require(:category).permit( :category )
    end
end
