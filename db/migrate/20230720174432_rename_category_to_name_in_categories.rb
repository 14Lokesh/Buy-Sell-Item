# frozen_string_literal: true

# This is a class
class RenameCategoryToNameInCategories < ActiveRecord::Migration[6.1]
  def change
    rename_column :categories, :category, :name
    change_column :categories, :name, :string, null: false, limit: 20, unique: true
  end
end
