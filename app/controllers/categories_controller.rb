# frozen_string_literal: true

# This is a sample class representing an Category controller.
class CategoriesController < ApplicationController
  before_action :require_user_logged_in!
  before_action :add_category, only: %i[edit update destroy]
  before_action :all_category, only: %i[index new]
  before_action :check_admin
  def index
    @categories = Category.page(params[:page]).per(5)
  end

  def new
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

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path, flash: { notice: 'Category was successfully updated' }
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, flash: { notice: 'Category was successfully deleted.' }
  end

  def add_category
    @category = Category.find(params[:id])
  end

  def all_category
    @categories = Category.all
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
