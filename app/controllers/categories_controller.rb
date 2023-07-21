# frozen_string_literal: true

# This is a sample class representing an Category controller.
class CategoriesController < ApplicationController
  before_action :require_user_logged_in!
  before_action :check_admin
  def index
    @categories = Category.all
    @categories = Category.page(params[:page]).per(5)
  end

  def new
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, flash: { notice: 'Category has been added' }
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, flash: { notice: 'Category was successfully updated' }
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, flash: { notice: 'Category was successfully deleted.' }
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
