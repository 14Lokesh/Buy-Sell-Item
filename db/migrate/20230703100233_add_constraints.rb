# frozen_string_literal: true

class AddConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :username, :string, null: false, limit: 30
    change_column :users, :email, :string, null: false, limit: 50
    add_index :users, :email, unique: true
    change_column :users, :password_digest, :string, null: false
    change_column :notifications, :message, :string, null: false
    change_column :items, :title, :string, null: false, limit: 30
    change_column :items, :description, :string, null: false, limit: 100
    change_column :items, :username, :string, null: false
    change_column :items, :phone, :string, null: false, length: { is: 10 }, numericality: { only_integer: true }
    change_column :items, :city, :string, null: false
    change_column :categories, :category, :string, null: false, limit: 20, unique: true
    change_column :messages, :body, :text, null: false
  end
end
