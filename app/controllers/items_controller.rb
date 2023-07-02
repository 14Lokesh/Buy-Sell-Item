# frozen_string_literal: true
class ItemsController < ApplicationController
    before_action :require_user_logged_in! ,only: [:product, :new]
    def index
        @item = Item.all
    end
    def new
        @item = Item.new
    end

    def create
        @item= Item.new(item_params)
        @item.user_id= current_user.id
        # binding.pry
        if @item.save      
           redirect_to root_path , notice: "Sent to admin for approval"
        else
             render :new 
        end
    end

    def approved_ad
        @item = Item.all
    end

    def show
        @item = Item.find(params[:id])
        @review = Review.new
    end

     # query2 = params[:search_items].presence && params[:search_items][:query2] 
             # query1 = params[:search_items].presence && params[:search_items][:query1]   
               # if query1.present? || query2.present?
        #   @items = Item.search_data(query1, query2)   
        # else
        #      @items = []
        # end

        def search
            query = params.dig(:search_items, :query)
            city = params.dig(:search_items, :city)
          
            search_definition = {
              query: {
                bool: {
                  must: []
                }
              }
            }
          
            if query.present?
              search_definition[:query][:bool][:must] << {
                wildcard: {
                  title: {
                    value: "*#{query}*"
                  }
                }
              }
            end
          
            if city.present?
              search_definition[:query][:bool][:filter] = {
                term: {
                  city: city
                }
              }
            end
          
            @items = query.present? ? Item.search(search_definition) : []
            # render 'welcome/search'
          end
          
          

    private
    def item_params
        params.require(:item).permit(:title, :description, :username, :phone , :city, :approved, :user_id, :approved_by_id , :category_id, images: [])
    end
end
